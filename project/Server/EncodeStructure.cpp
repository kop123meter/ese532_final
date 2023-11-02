main(input_packet){

  // general idea: 1. CDC把inputpacket划分成许多chunks 
  //               2. SHA计算每一个chunk的 hash value
  //               3. ChunkDuplicationDetect 检测hash value一样的chunk，
  //                  （方法：挨个把chunk放在list里， 后面的chunk 的hash value 如果跟list里的chunk的hash value重复
  //                         那它就是duplicated chunk，记录它的信息到 DuplicatedChunks_Info[] 里
  //                         如果它的hash value和list里的chunk的hash value都不一样 那它就是unique chunk，把它的信息加到UniqueChunks_Boundaries[]里
  //               4. LZW 计算unique chunk们的压缩版
  //               5. OutputFunction 生成output，unique chunk输出它的压缩版本，duplicated chunk输出它对应的unique chunk的压缩版本
CDC(input_packet;Boundaries_Array[]){
// calculate hash value of windows, output positions of doundaries
// input: input_packet
// output: Boundaries_Array: contains positions of doundaries
}

ChunkMatching(input_packet;Boundaries_Array[];UniqueChunks_Boundries[];DuplicatedChunks_Info[]){
// detect duplicated chunks, output unique chunks boundaries and duplicated chunks info
// input 1: input_packet
// input 2: Boundaries_Array[]
// output 1: UniqueChunks_Boundries[] indicates the unique chunks' boundries
// output 2: DuplicatedChunks_Info[] indicates the duplicated chunks' information, 
//         including its boundaries & indicate the according unique chunk.

  SHA(input_packet;Boundries_Array[];Hash_Array[]){
  // base on positions of boundaries, calculate hash value of each chunk
  // input 1: input_packet
  // input 2: Boundaries_Array[]
  // output: Hash_Array[]: indicates the hash value of each chunk 
  }
  ChunkDuplicationDetect(Boundaries_Array[];Hash_Array[];UniqueChunks_Boundaries[];DuplicatedChunks_Info[]){
  //check duplication in Hash_Array,record duplicated chunks info and unique chunks boundaries
  // output: UniqueChunks_Boundaries[] : indicates the boundaries of unique chunks
  // output: DuplicatedChunks_Info[] : indicates the duplicated chunks' information, 
  //         including their boundaries & indicating their according unique chunk.

  }
}
LZW(input_packet;UniqueChunks_Boundaries[];Deduplicated_Uniquechunks[]){
// output deduplicated unique chunks
// input1: input_packet
// input2: UniqueChunks_Boundaries[]:indicates the boundaries of unique chunks
// output: Deduplicated_Uniquechunks[]: Deduplicated version of uniquechunks
}
Output_Function(UniqueChunks_Boundaries[];Deduplicated_Uniquechunks[];DuplicatedChunks_Info[];output_packet){
  // base on deduplicated unique chunks and duplicated chunks' info generate output_packet
  // for unique chunks, output their's deduplicated version
  // for duplicated chunks, output their according unique chunks' deduplicated version
  // input 1: UniqueChunks_Boundaries[]:indicates the boundaries of unique chunks
  // input 2: Deduplicated_Uniquechunks[]: Deduplicated version of uniquechunks
  // input 3: DuplicatedChunks:Info[] : indicates the duplicated chunks' information, 
  //         including its boundaries & indicate the position of the same unique chunk.
  // output: output_packet: deduplicated version of input_packet
}

}
