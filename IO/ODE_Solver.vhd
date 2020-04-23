library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity ODE_Solver is
    port(CLK, RST, INT, load_process, enable_Receiving_IO, enable_output_IO, done_row: in std_logic;
    result_ready, done_reading_bus, done_output_data: out std_logic;
    CPU_Bus : inout std_logic_vector(31 downto 0));
end entity;

architecture ODE_Solver_arch of ODE_Solver is
    constant end_T_address: integer := 5004;
    constant end_Output_address: integer := 2504;
    signal mem_addr_recv, mem_addr_send, addr_io: integer;

    constant addr_euler1: std_logic_vector(13 DOWNTO 0) := (others => '0');
    constant addr_euler2: std_logic_vector(13 DOWNTO 0) := (others => '0');
    constant mem1_data_euler1_in: std_logic_vector(63 DOWNTO 0) := (others => '0');

    constant mem2_data_euler1_in: std_logic_vector(63 DOWNTO 0) := (others => '0');
    signal mem1_data_euler1_out, mem1_data_euler2_out, mem1_data_io_out, mem2_data_euler1_out, memory_data,
            mem2_data_euler2_out, mem1_data_io_in, mem2_data_io_out, mem2_data_io_in, mem_bus_io_recv: std_logic_vector(63 DOWNTO 0);
    signal mem1_wr_en, mem2_wr_en, mem1_port_IO_enable, mem2_port_IO_enable, mem1_write_IO, mem2_write_IO: std_logic;
begin
    io_recv: entity work.IO_Receive generic map(CPU_Bus_Width => 32) port map(CPU_Bus, enable_Receiving_IO, CLK, done_row,
										RST, done_reading_bus, mem_bus_io_recv, mem_addr_recv,
										mem1_wr_en, mem2_wr_en); 
                                             
    io_send: entity work.IO_Output port map(enable_output_IO, CLK, RST, end_T_address, 
                                            end_Output_address, memory_data,
                                            CPU_Bus, mem_addr_send, done_output_data); 

    mem1: entity work.RAM2 generic map(word_size => 64) port map(CLK, '0', '0', mem1_write_IO, '0', '0', mem1_port_IO_enable,
                                                                 addr_euler1, addr_euler2, addr_io,
                                                                 mem1_data_euler1_out, mem1_data_euler2_out, mem1_data_io_out,
                                                                 mem1_data_euler1_in, mem1_data_io_in);

    mem2: entity work.RAM2 generic map(word_size => 64) port map(CLK, '0', '0', mem2_write_IO, '0', '0', mem2_port_IO_enable,
                                                                 addr_euler1, addr_euler2, addr_io,
                                                                 mem2_data_euler1_out, mem2_data_euler2_out, mem2_data_io_out,
                                                                 mem2_data_euler1_in, mem2_data_io_in);

    mem1_port_IO_enable <= '1' when enable_output_IO = '1' or enable_Receiving_IO = '1' else '0';
    mem2_port_IO_enable <= '1' when enable_Receiving_IO = '1' else '0';
    mem1_write_IO <= '1' when enable_Receiving_IO = '1' and mem1_wr_en = '1' else '0';
    mem2_write_IO <= '1' when enable_Receiving_IO = '1' and mem2_wr_en = '1' else '0';
    memory_data <= mem1_data_io_out when enable_output_IO = '1' else (others => '0');
    mem1_data_io_in <= mem_bus_io_recv;
    mem2_data_io_in <= mem_bus_io_recv;
    addr_io <= mem_addr_recv when enable_Receiving_IO = '1' else mem_addr_send when enable_output_IO = '1' else 0;
    CPU_Bus <= (others => '0') when enable_output_IO = '0' and enable_Receiving_IO = '0';
end architecture;