DEFAULT_FILE="LittlePrince.txt"  # Default file to send
DEFAULT_IP="10.10.7.1"      # Default server IP address
DEFAULT_BLOCKSIZE=8192      # Default block size
DEFAULT_SLEEPTIME=5         # Default sleep time in microseconds

# Allow overriding the default values via command-line arguments
IP=${1:-$DEFAULT_IP}
FILE=${1:-$DEFAULT_FILE}
BLOCKSIZE=${3:-$DEFAULT_BLOCKSIZE}
SLEEPTIME=${4:-$DEFAULT_SLEEPTIME}

# Path to the client binary
CLIENT_BINARY="./client"  # Replace with the actual path to your compiled client program

# Check if the client binary exists
if [ ! -f "$CLIENT_BINARY" ]; then
    echo "Client binary not found at $CLIENT_BINARY"
    exit 1
fi

# Invoke the client with the specified parameters
$CLIENT_BINARY -s $SLEEPTIME -i $IP -f $FILE -b $BLOCKSIZE
