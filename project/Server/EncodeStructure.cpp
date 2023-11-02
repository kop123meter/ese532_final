main(input_packet){
CDC(input_packet;Boundaries_Array[]){
// calculate hash value of windows, output positions of doundaries
// input: input_packet
// output: Boundaries_Array: contains the position of doundaries
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
  // output: DuplicatedChunks:Info[] : indicates the duplicated chunks' information, 
  //         including its boundaries & indicate the according unique chunk.

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
