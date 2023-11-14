#include "Utilities.h"

void Exit_with_error(const char *s)
{
    printf("%s\n", s);
    exit(EXIT_FAILURE);
}

void Load_data(unsigned char *Data)
{
    unsigned int Size = FRAMES * INPUT_FRAME_SIZE;

    FILE *File = fopen("./data/Input.bin", "rb");
    if (File == NULL)
        Exit_with_error("fopen for Load_data failed");

    if (fread(Data, 1, Size, File) != Size)
        Exit_with_error("fread for Load_data failed");

    if (fclose(File) != 0)
        Exit_with_error("fclose for Load_data failed");
}

// from https://eli.thegreenplace.net/2016/c11-threads-affinity-and-hyperthreading/
void pin_thread_to_cpu(std::thread &t, int cpu_num)
{
#if defined(WIN32) || defined(_WIN32) || defined(__WIN32__) || defined(__NT__) || defined(__APPLE__)
    return;
#else
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(cpu_num, &cpuset);
    int rc =
        pthread_setaffinity_np(t.native_handle(), sizeof(cpu_set_t), &cpuset);
    if (rc != 0)
    {
        std::cerr << "Error calling pthread_setaffinity_np: " << rc << "\n";
    }
#endif
}

void pin_main_thread_to_cpu0()
{
#if defined(WIN32) || defined(_WIN32) || defined(__WIN32__) || defined(__NT__) || defined(__APPLE__)
    return;
#else
    pthread_t thread;
    thread = pthread_self();
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(0, &cpuset);
    int rc =
        pthread_setaffinity_np(thread, sizeof(cpu_set_t), &cpuset);
    if (rc != 0)
    {
        std::cerr << "Error calling pthread_setaffinity_np: " << rc << "\n";
    }
#endif
}

void Store_data(const char *Filename, unsigned char *Data, unsigned int Size)
{
    FILE *File = fopen(Filename, "wb");
    if (File == NULL)
        Exit_with_error("fopen for Store_data failed");

    if (fwrite(Data, 1, Size, File) != Size)
        Exit_with_error("fwrite for Store_data failed");

    if (fclose(File) != 0)
        Exit_with_error("fclose for Store_data failed");
}

void Check_data(unsigned char *Data, unsigned int Size)
{
    int error_code = 0;
    unsigned char *Data_golden = (unsigned char *)malloc(MAX_OUTPUT_SIZE);
    FILE *File = fopen("./data/Golden.bin", "rb");
    if (File == NULL)
        Exit_with_error("fopen for Check_data failed");

    if (Size == 0)
        Exit_with_error("fclose for Check_data failed, Size==0");

    if (fread(Data_golden, 1, Size, File) != Size)
        Exit_with_error("fread for Check_data failed, Different Size");

    if (fclose(File) != 0)
        Exit_with_error("fclose for Check_data failed");

    for (unsigned int i = 0; i < Size; i++)
    {
        if (Data_golden[i] != Data[i])
        {
            free(Data_golden);
            error_code = i + 1;
        }
    }

    free(Data_golden);

    if (error_code != 0)
    {
        printf("You got errors in data %d\n", error_code);
        Exit_with_error("Input.bin and Golden.bin doesn't match");
    }
    else
    {
        printf("Application completed successfully.\n");
    }
}

std::vector<cl::Device> get_xilinx_devices() 
{
    size_t i;
    cl_int err;
    std::vector<cl::Platform> platforms;
    err = cl::Platform::get(&platforms);
    cl::Platform platform;
    for (i  = 0 ; i < platforms.size(); i++){
        platform = platforms[i];
        std::string platformName = platform.getInfo<CL_PLATFORM_NAME>(&err);
        if (platformName == "Xilinx"){
            std::cout << "INFO: Found Xilinx Platform" << std::endl;
            break;
        }
    }
    if (i == platforms.size()) {
        std::cout << "ERROR: Failed to find Xilinx platform" << std::endl;
        exit(EXIT_FAILURE);
    }
   
    //Getting ACCELERATOR Devices and selecting 1st such device 
    std::vector<cl::Device> devices;
    err = platform.getDevices(CL_DEVICE_TYPE_ACCELERATOR, &devices);
    return devices;
}
   
char* read_binary_file(const std::string &xclbin_file_name, unsigned &nb) 
{
    if(access(xclbin_file_name.c_str(), R_OK) != 0) {
        printf("ERROR: %s xclbin not available please build\n", xclbin_file_name.c_str());
        exit(EXIT_FAILURE);
    }
    //Loading XCL Bin into char buffer 
    std::cout << "INFO: Loading '" << xclbin_file_name << "'\n";
    std::ifstream bin_file(xclbin_file_name.c_str(), std::ifstream::binary);
    bin_file.seekg (0, bin_file.end);
    nb = bin_file.tellg();
    bin_file.seekg (0, bin_file.beg);
    char *buf = new char [nb];
    bin_file.read(buf, nb);
    return buf;
}