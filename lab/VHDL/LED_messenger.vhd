library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LED_messenger is
generic(
    freq : integer := 100_000_000
    );
port(
     clk : in std_logic
    ;messenger_clk : out std_logic
    ;messenger_data : out std_logic
    ;switch         : in std_logic_vector(7 downto 0)
    );
end entity;


architecture RTL of LED_messenger is

signal enable   : std_logic := '0';
signal cnt      : unsigned(31 downto 0) := (others => '0');

signal PWM_cnt  : unsigned(31 downto 0) := (others => '0');

signal m_clk_i : std_logic := '0';
signal m_data_i : std_logic := '0';

constant barker_seq : std_logic_vector(18 downto 0) := "11100010010" & "01010101";
constant message : std_logic_vector(159 downto 0) :=
  std_logic_vector(to_unsigned(84 ,8))
& std_logic_vector(to_unsigned(104,8))
& std_logic_vector(to_unsigned(105,8))
& std_logic_vector(to_unsigned(115,8))
& std_logic_vector(to_unsigned(32 ,8))
& std_logic_vector(to_unsigned(105,8))
& std_logic_vector(to_unsigned(115,8))
& std_logic_vector(to_unsigned(32 ,8))
& std_logic_vector(to_unsigned(97 ,8))
& std_logic_vector(to_unsigned(32 ,8))
& std_logic_vector(to_unsigned(115,8))
& std_logic_vector(to_unsigned(97 ,8))
& std_logic_vector(to_unsigned(109,8))
& std_logic_vector(to_unsigned(112,8))
& std_logic_vector(to_unsigned(108,8))
& std_logic_vector(to_unsigned(101,8))
& std_logic_vector(to_unsigned(32 ,8))
& std_logic_vector(to_unsigned(108,8))
& std_logic_vector(to_unsigned(97 ,8))
& std_logic_vector(to_unsigned(98 ,8));

signal  all_message : std_logic_vector(178 downto 0) := barker_seq & message;



signal inc_req          : std_logic := '0';
signal dec_req          : std_logic := '0';
signal switch_r         : std_logic_vector(7 downto 0) := (others => '0');
signal switch_2r        : std_logic_vector(7 downto 0) := (others => '0');

signal cs : integer;

signal cnt_limit : unsigned(31 downto 0) := to_unsigned(freq/15,32);


signal PWM : std_logic := '0';


begin

pwmer_i : entity work.PWMer generic map(
    freq => FREQ
    )
    Port MAP
    ( clk => clk,
      pwm => pwm
    );




process(clk)
begin
    if rising_edge(clk) then
        enable <= '0'; 
        if cnt = 0 then
            cnt <= cnt_limit;
            enable <= '1';
        else
            cnt <= cnt - 1;
        end if;
        
        
        
        if inc_req = '1' then
            cnt_limit <= cnt_limit + 100_000;
        end if;

        if dec_req = '1' then
            cnt_limit <= cnt_limit - 100_000;
        end if;
        
    end if;
    
    messenger_data <= m_data_i and pwm;
    messenger_clk <= m_clk_i and pwm;
end process;
            
            
process(clk)
begin
    if rising_edge(clk) then
        if enable = '1' then
            m_clk_i <= not m_clk_i;
            if m_clk_i = '1' then
                m_data_i <= all_message(all_message'high);
                all_message <= all_message(all_message'high-1 downto 0) & all_message(all_message'high);
            end if;
        end if;
    end if;
end process;


process(clk)
variable sw_cnt : integer := 0;
begin
    if rising_edge(clk) then
        inc_req <= '0';
        dec_req <= '0';
        switch_r <= switch;
        switch_2r <= switch_r;
        case cs is
            when 0 =>
                if switch_r(0) = '1' and switch_2r(0) = '0' then
                    cs <= 1;
                end if;
                if switch_r(1) = '1' and switch_2r(1) = '0' then
                    cs <= 2;
                end if;
            
            when 1 =>
                sw_cnt := sw_cnt + 1;
                if sw_cnt = 10_000 then
                    if switch_2r(0) = '1' then
                        inc_req <= '1';
                        cs <= 0;
                        sw_cnt := 0;
                    end if;
                end if;
            
            when 2 =>
                sw_cnt := sw_cnt + 1;
                if sw_cnt = 10_000 then
                    if switch_2r(1) = '1' then
                        dec_req <= '1';
                        cs <= 0;
                        sw_cnt := 0;
                    end if;
                end if;
            
            when others =>
                cs <= 0;
        end case;
    end if;
end process;
            

end architecture;


