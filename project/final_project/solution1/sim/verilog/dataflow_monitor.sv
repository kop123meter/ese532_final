
`include "sample_manager.sv"
`include "csv_file_dump.sv"
`include "df_fifo_monitor.sv"
`include "df_process_monitor.sv"
`include "nodf_module_monitor.sv"
`timescale 1ns/1ps

// top module for dataflow related monitors
module dataflow_monitor(
input logic clock,
input logic reset,
input logic finish
);

    df_fifo_intf fifo_intf_1(clock,reset);
    assign fifo_intf_1.rd_en = AESL_inst_hardware_encoding.input_stream_U.if_read;
    assign fifo_intf_1.wr_en = AESL_inst_hardware_encoding.input_stream_U.if_write;
    assign fifo_intf_1.fifo_rd_block = ~(AESL_inst_hardware_encoding.computing_U0.input_r_blk_n);
    assign fifo_intf_1.fifo_wr_block = ~(AESL_inst_hardware_encoding.read_input5_U0.input_r_blk_n);
    assign fifo_intf_1.finish = finish | deadlock_detector.AESL_deadlock_report_unit_inst.find_df_deadlock;
    csv_file_dump fifo_csv_dumper_1;
    csv_file_dump cstatus_csv_dumper_1;
    df_fifo_monitor fifo_monitor_1;
    df_fifo_intf fifo_intf_2(clock,reset);
    assign fifo_intf_2.rd_en = AESL_inst_hardware_encoding.output_c_U.if_read;
    assign fifo_intf_2.wr_en = AESL_inst_hardware_encoding.output_c_U.if_write;
    assign fifo_intf_2.fifo_rd_block = ~(AESL_inst_hardware_encoding.write_output_U0.output_r_blk_n);
    assign fifo_intf_2.fifo_wr_block = ~(AESL_inst_hardware_encoding.read_input5_U0.output_out_blk_n);
    assign fifo_intf_2.finish = finish | deadlock_detector.AESL_deadlock_report_unit_inst.find_df_deadlock;
    csv_file_dump fifo_csv_dumper_2;
    csv_file_dump cstatus_csv_dumper_2;
    df_fifo_monitor fifo_monitor_2;
    df_fifo_intf fifo_intf_3(clock,reset);
    assign fifo_intf_3.rd_en = AESL_inst_hardware_encoding.output_stream_U.if_read;
    assign fifo_intf_3.wr_en = AESL_inst_hardware_encoding.output_stream_U.if_write;
    assign fifo_intf_3.fifo_rd_block = ~(AESL_inst_hardware_encoding.write_output_U0.output_stream_blk_n);
    assign fifo_intf_3.fifo_wr_block = ~(AESL_inst_hardware_encoding.computing_U0.output_r_blk_n);
    assign fifo_intf_3.finish = finish | deadlock_detector.AESL_deadlock_report_unit_inst.find_df_deadlock;
    csv_file_dump fifo_csv_dumper_3;
    csv_file_dump cstatus_csv_dumper_3;
    df_fifo_monitor fifo_monitor_3;

    df_process_intf process_intf_1(clock,reset);
    assign process_intf_1.ap_start = AESL_inst_hardware_encoding.read_input5_U0.ap_start;
    assign process_intf_1.ap_ready = AESL_inst_hardware_encoding.read_input5_U0.ap_ready;
    assign process_intf_1.ap_done = AESL_inst_hardware_encoding.read_input5_U0.ap_done;
    assign process_intf_1.ap_continue = AESL_inst_hardware_encoding.read_input5_U0.ap_continue;
    assign process_intf_1.real_start = AESL_inst_hardware_encoding.read_input5_U0.real_start;
    assign process_intf_1.pin_stall = 1'b0;
    assign process_intf_1.pout_stall = 1'b0 | ~AESL_inst_hardware_encoding.read_input5_U0.input_r_blk_n | ~AESL_inst_hardware_encoding.read_input5_U0.output_out_blk_n;
    assign process_intf_1.finish = finish | deadlock_detector.AESL_deadlock_report_unit_inst.find_df_deadlock;
    csv_file_dump pstall_csv_dumper_1;
    csv_file_dump pstatus_csv_dumper_1;
    df_process_monitor process_monitor_1;
    df_process_intf process_intf_2(clock,reset);
    assign process_intf_2.ap_start = AESL_inst_hardware_encoding.computing_U0.ap_start;
    assign process_intf_2.ap_ready = AESL_inst_hardware_encoding.computing_U0.ap_ready;
    assign process_intf_2.ap_done = AESL_inst_hardware_encoding.computing_U0.ap_done;
    assign process_intf_2.ap_continue = AESL_inst_hardware_encoding.computing_U0.ap_continue;
    assign process_intf_2.real_start = AESL_inst_hardware_encoding.computing_U0.ap_start;
    assign process_intf_2.pin_stall = 1'b0 | ~AESL_inst_hardware_encoding.computing_U0.input_r_blk_n;
    assign process_intf_2.pout_stall = 1'b0 | ~AESL_inst_hardware_encoding.computing_U0.output_r_blk_n;
    assign process_intf_2.finish = finish | deadlock_detector.AESL_deadlock_report_unit_inst.find_df_deadlock;
    csv_file_dump pstall_csv_dumper_2;
    csv_file_dump pstatus_csv_dumper_2;
    df_process_monitor process_monitor_2;
    df_process_intf process_intf_3(clock,reset);
    assign process_intf_3.ap_start = AESL_inst_hardware_encoding.write_output_U0.ap_start;
    assign process_intf_3.ap_ready = AESL_inst_hardware_encoding.write_output_U0.ap_ready;
    assign process_intf_3.ap_done = AESL_inst_hardware_encoding.write_output_U0.ap_done;
    assign process_intf_3.ap_continue = AESL_inst_hardware_encoding.write_output_U0.ap_continue;
    assign process_intf_3.real_start = AESL_inst_hardware_encoding.write_output_U0.ap_start;
    assign process_intf_3.pin_stall = 1'b0 | ~AESL_inst_hardware_encoding.write_output_U0.output_stream_blk_n | ~AESL_inst_hardware_encoding.write_output_U0.output_r_blk_n;
    assign process_intf_3.pout_stall = 1'b0;
    assign process_intf_3.finish = finish | deadlock_detector.AESL_deadlock_report_unit_inst.find_df_deadlock;
    csv_file_dump pstall_csv_dumper_3;
    csv_file_dump pstatus_csv_dumper_3;
    df_process_monitor process_monitor_3;

    nodf_module_intf module_intf_1(clock,reset);
    assign module_intf_1.ap_start = AESL_inst_hardware_encoding.ap_start;
    assign module_intf_1.ap_ready = AESL_inst_hardware_encoding.ap_ready;
    assign module_intf_1.ap_done = AESL_inst_hardware_encoding.ap_done;
    assign module_intf_1.ap_continue = AESL_inst_hardware_encoding.ap_continue;
    assign module_intf_1.finish = finish;
    csv_file_dump mstatus_csv_dumper_1;
    nodf_module_monitor module_monitor_1;
    nodf_module_intf module_intf_2(clock,reset);
    assign module_intf_2.ap_start = AESL_inst_hardware_encoding.computing_U0.grp_assoc_lookup_fu_523.ap_start;
    assign module_intf_2.ap_ready = AESL_inst_hardware_encoding.computing_U0.grp_assoc_lookup_fu_523.ap_ready;
    assign module_intf_2.ap_done = AESL_inst_hardware_encoding.computing_U0.grp_assoc_lookup_fu_523.ap_done;
    assign module_intf_2.ap_continue = 1'b1;
    assign module_intf_2.finish = finish;
    csv_file_dump mstatus_csv_dumper_2;
    nodf_module_monitor module_monitor_2;

    sample_manager sample_manager_inst;

initial begin
    sample_manager_inst = new;

    fifo_csv_dumper_1 = new("./depth1.csv");
    cstatus_csv_dumper_1 = new("./chan_status1.csv");
    fifo_monitor_1 = new(fifo_csv_dumper_1,fifo_intf_1,cstatus_csv_dumper_1);
    fifo_csv_dumper_2 = new("./depth2.csv");
    cstatus_csv_dumper_2 = new("./chan_status2.csv");
    fifo_monitor_2 = new(fifo_csv_dumper_2,fifo_intf_2,cstatus_csv_dumper_2);
    fifo_csv_dumper_3 = new("./depth3.csv");
    cstatus_csv_dumper_3 = new("./chan_status3.csv");
    fifo_monitor_3 = new(fifo_csv_dumper_3,fifo_intf_3,cstatus_csv_dumper_3);

    pstall_csv_dumper_1 = new("./stalling1.csv");
    pstatus_csv_dumper_1 = new("./status1.csv");
    process_monitor_1 = new(pstall_csv_dumper_1,process_intf_1,pstatus_csv_dumper_1);
    pstall_csv_dumper_2 = new("./stalling2.csv");
    pstatus_csv_dumper_2 = new("./status2.csv");
    process_monitor_2 = new(pstall_csv_dumper_2,process_intf_2,pstatus_csv_dumper_2);
    pstall_csv_dumper_3 = new("./stalling3.csv");
    pstatus_csv_dumper_3 = new("./status3.csv");
    process_monitor_3 = new(pstall_csv_dumper_3,process_intf_3,pstatus_csv_dumper_3);

    mstatus_csv_dumper_1 = new("./module_status1.csv");
    module_monitor_1 = new(module_intf_1,mstatus_csv_dumper_1);
    mstatus_csv_dumper_2 = new("./module_status2.csv");
    module_monitor_2 = new(module_intf_2,mstatus_csv_dumper_2);

    sample_manager_inst.add_one_monitor(fifo_monitor_1);
    sample_manager_inst.add_one_monitor(fifo_monitor_2);
    sample_manager_inst.add_one_monitor(fifo_monitor_3);
    sample_manager_inst.add_one_monitor(process_monitor_1);
    sample_manager_inst.add_one_monitor(process_monitor_2);
    sample_manager_inst.add_one_monitor(process_monitor_3);
    sample_manager_inst.add_one_monitor(module_monitor_1);
    sample_manager_inst.add_one_monitor(module_monitor_2);
    
    fork
        sample_manager_inst.start_monitor();
        last_transaction_done;
    join
    disable fork;

    sample_manager_inst.start_dump();
end

    task last_transaction_done();
        wait(reset == 0);
        while(1) begin
            if (finish == 1'b1 || deadlock_detector.AESL_deadlock_report_unit_inst.find_df_deadlock == 1'b1)
                break;
            else
                @(posedge clock);
        end
    endtask


endmodule
