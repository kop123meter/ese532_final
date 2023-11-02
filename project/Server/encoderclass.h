#ifndef ENCODERCLASS_H
#define ENCODERCLASS_H
class encoderclass
{

public:
    int chunk_number;
    int chunk_boundary[];
    encoderclass(){
        chunk_number = 0;

    };
    ~encoderclass(){}; //destructor

    void cdc_hash(unsigned char *buff, unsigned int buff_size);
    void cdc(unsigned char *buff, unsigned int buff_size);
    
};

#endif
