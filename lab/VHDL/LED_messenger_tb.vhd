library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LED_messenger_tb is
end entity;


architecture RTL of LED_messenger_tb is

signal clk              : std_logic := '0';
signal messenger_clk    : std_logic;
signal messenger_data   : std_logic := '0';
signal switch           : std_logic_vector(7 downto 0) := (others =>'0');

begin



UUT : entity work.LED_messenger
generic map (
    freq => 10_000
    )
port map(
     clk            => clk           
    ,messenger_clk  => messenger_clk  
    ,messenger_data => messenger_data 
    ,switch         => switch        
    );


clk <= not clk after 5 ns;

process
begin
    wait for 1000 ns;
    wait until rising_edge(clk);
    switch(0) <= '1';
    wait for 100000 ns;
    wait until rising_edge(clk);
    switch(1) <= '1';
    wait;
end process;

end architecture;


