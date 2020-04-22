library IEEE;
use IEEE.std_logic_1164.all;

entity ODE_Solver is
    port(CLK, RST, load_process, enable_Receiving_IO, enable_output_IO, done_row: in std_logic;
    result_ready, done_reading_bus, done_output_data: out std_logic;
    CPU_Bus : inout std_logic_vector(31 downto 0));
end entity;

architecture ODE_Solver_arch of ODE_Solver is
    constant signal addr_euler1 std_logic_vector(13 DOWNTO 0) := (others => '0');
    constant signal addr_euler2 std_logic_vector(13 DOWNTO 0) := (others => '0');
    signal addr_io integer;
    constant signal mem1_data_euler1_out std_logic_vector(63 DOWNTO 0);
    constant signal mem1_data_euler2_out std_logic_vector(63 DOWNTO 0);
    signal mem1_data_io_out std_logic_vector(63 DOWNTO 0);
    constant signal mem1_data_euler1_in std_logic_vector(63 DOWNTO 0) := (others => '0');
    signal mem1_data_io_in std_logic_vector(63 DOWNTO 0);

    constant signal mem2_data_euler1_out std_logic_vector(63 DOWNTO 0);
    constant signal mem2_data_euler2_out std_logic_vector(63 DOWNTO 0);
    signal mem2_data_io_out std_logic_vector(63 DOWNTO 0);
    signal mem_bus_io_recv std_logic_vector(63 DOWNTO 0);
    constant signal mem2_data_euler1_in std_logic_vector(63 DOWNTO 0) := (others => '0');
    signal mem2_data_io_in std_logic_vector(63 DOWNTO 0);
    signal mem1_port_IO_enable std_logic;
    signal mem2_port_IO_enable std_logic;
    signal mem1_write_IO std_logic;
    signal mem2_write_IO std_logic;
    signal mem_bus_io_recv std_logic_vector(63 DOWNTO 0);
begin
    io_recv: entity work.IO_Receive port map(CPU_Bus, enable_Receiving_IO, CLK, done_row,
                                             RST, mem_bus_io_recv, mem_addr_recv, mem1_wr_en, mem2_wr_en); 
                                             
    io_send: entity work.IO_Output port map(enable_output_IO, CLK, RST, end_T_address, 
                                            end_Output_address, memory_data, mem1_data_io_out,
                                            CPU_Bus, mem_addr_send, done_output_data); 

    mem1: entity work.RAM2 generic map(word_size => 64) port map(CLK, '0', '0', mem1_write_IO, '0', '0', mem1_port_IO_enable,
                                                                 addr_euler1, addr_euler2, address_IO,
                                                                 mem1_data_euler1_out, mem1_data_euler2_out, mem1_data_io_out,
                                                                 mem1_data_euler1_in, mem1_data_io_in);

    mem2: entity work.RAM2 generic map(word_size => 64) port map(CLK, '0', '0', mem2_write_IO, '0', '0', mem2_port_IO_enable,
                                                                 addr_euler1, addr_euler2, address_IO,
                                                                 mem2_data_euler1_out, mem2_data_euler2_out, mem2_data_io_out,
                                                                 mem2_data_euler1_in, mem2_data_io_in);

    mem1_port_IO_enable <= '1' when enable_output_IO or enable_Receiving_IO else '0';
    mem1_port_IO_enable <= '1' when enable_output_IO or enable_Receiving_IO else '0';
    mem1_write_IO <= '1' when enable_Receiving_IO and mem1_wr_en else '0';
    mem2_write_IO <= '1' when enable_Receiving_IO and mem2_wr_en else '0';
    memory_data <= mem1_data_io_out when enable_output_IO else (others => '0');
    mem1_data_io_in <= mem_bus_io_recv;
    mem2_data_io_in <= mem_bus_io_recv;
end architecture;