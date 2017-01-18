----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/17/2017 02:46:50 PM
-- Design Name: 
-- Module Name: PWMer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWMer is generic(
    freq : integer := 100_000_000
    );
    Port ( clk : in STD_LOGIC;
           pwm : out STD_LOGIC);
end PWMer;

architecture Behavioral of PWMer is

signal tick : std_logic := '0';


begin


process(clk)
variable tick_cnt : integer := FREQ/20_000;
begin 
    if rising_edge(clk) then
        tick <= '0';
        if tick_cnt = 0 then
            tick_cnt := FREQ/20_000-1;
            tick <= '1';
        else
            tick_cnt := tick_cnt - 1;
        end if;
    end if;
end process;

process(clk)
variable pwm_cnt : integer := 0;
begin
    if rising_edge(clk) then
        if tick= '1' then
            if pwm_cnt = 63 then
                pwm_cnt := 0;
            else
                pwm_cnt := pwm_cnt + 1;
            end if;
        end if;
        
        if pwm_cnt < 2 then
            PWM <= '1';
        else
            PWM <= '0';
        end if;
    end if;
end process;
            
            
                


end Behavioral;
