library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CAproject is
	port (clk   : in  STD_LOGIC ;
			reset : in  STD_LOGIC ;
			din   : in  STD_LOGIC ;
			fw    : out STD_LOGIC ;
			rw    : out STD_LOGIC ;
			lef   : out STD_LOGIC ;
			led   : out STD_LOGIC ;
			righ  : out STD_LOGIC);
			
end CAproject;


architecture Behavioral of CAproject is 

type state is (ready,start1);
signal ps1 : state := ready;
signal start,stop : std_logic ;
signal store :std_logic_vector (7 downto 0) := "00000000";


begin

process (clk)

variable 1 : integer := 0;
begin 
if clk'event and clk= '1' then

if ps1 = ready then
start <= din;
end if;

--------------------start bit detect logic--------------------
if start = '0' then
ps1 <= start1;
else 
ps1 <= ready;
end if;
--------------------16xbaudrae sampling mahod--------------------
if ps1 = start1 then
i := I + 1;

if i = 260 then 
start <= din;
end if;

if i = 7800 then
store(1) <= din;
end if;

if i = 13000 then
store(1) <= din;
end if;

if i = 18200 then
store(2) <= din;
end if;

if i = 23400 then
store(3) <= din;
end if;

if i = 28600 then
store(4) <= din;
end if;

if i = 33800 then
store(5) <= din;
end if;

if i = 39000 then
store(6) <= din;
end if;

if i = 44200 then
store(7) <= din;
end if;

if i = 49400 then
stop <= din;
end if;

if i = 54600 then
i := 0;
ps1 <= ready;
end if;
end if;
end if;
end if;
end process;
--dout <= store (7 downto 0);

process (clk,reset,store)
variable i,j,k,l,m,n,p,q : integer := 0;


begin

if reset='1' then
fw <= '0' ;
rw <= '0' ;

else if rising_edge(clk) then

	if store = x"46" then     ----forward F
		
		led = 1;
		
		j := 0;
		k := 0;
		l := 0;
		m := 0;
		n := 0;
		p := 0;
		q := 0;
		i := i + 1;
		if i <= 1005000 then
			fw <= '0';
			rw <= '0';
		else if i > 1005000  and i < 1550000 then
			fw <= '1';
			rw <= '0';
		else if i= 1550000 then
			i :=0;
		end if;
		righ <= '0';
		lef <= '0';
		
	else if store = x"42" then ---backwad B
		i := 0;
		k := 0;
		l := 0;
		m := 0;
		n := 0;
		p := 0;
		q := 0;
		j := j + 1;
		
		if j<= 1005000 then
			fw <= '0';
			rw <= '0';
		else if j > 1005000 and k < 1550000 then
			fw <= '0';
			rw <= '1';
		else if j = 1550000 then
			j := 0;
		end if;
		righ <= '0';
		lef <= '0';
	
	else if store = x"4C" then  ----Left L
		i := 0; 
		j := 0;
		l := 0;	
		m := 0;
		n := 0;
		p := 0;
		q := 0;
		k := k + 1;
		
		if k <= 1005000 then
			righ <= '0';
			lef <= '0';
		else if k > 1005000 and k < 1550000 then
			righ <= '0';
			lef <= '1';
		else if k = 1550000 then
			k := 0;
		end if;
		fw <= '0';
		rw <= '0';
	

	else if store = x"52" then  ----right R
		i := 0; 
		j := 0;
		k := 0;	
		m := 0;
		n := 0;
		p := 0;
		q := 0;
		l := l + 1;
		
		if l <= 1005000 then
			righ <= '0';
			lef <= '0';
		else if l > 1005000 and l < 1550000 then
			righ <= '1';
			lef <= '0';
		else if l = 1550000 then
			l := 0;
		end if;
		fw <= '0';
		rw <= '0';
	
	else if store = x"49" then  ----forward right I
		i := 0;
		j := 0;
		k := 0;	
		l := 0;
		n := 0;
		p := 0;
		q := 0;
		m := m + 1;
		
		if m <= 1005000 then
			righ <= '0';
			lef <= '0';
			fw <= 0;
			rw <= 0;
		else if m > 1005000 and m < 1550000 then
			righ <= '1';
			lef <= '0';
			fw <= '1';
			rw <= '0';
		else if m = 1550000 then
			m := 0;
		end if;

	
	else if store = x"47" then  ----forward left G
		i := 0;
		j := 0;
		k := 0;	
		l := 0;
		m := 0;
		p := 0;
		q := 0;
		n := n + 1;
		
		if n <= 1005000 then
			righ <= '0';
			lef <= '0';
			fw <= 0;
			rw <= 0;
		else if n > 1005000 and n < 1550000 then
			righ <= '0';
			lef <= '1';
			fw <= '1';
			rw <= '0';
		else if n = 1550000 then
			n := 0;
		end if;

	
	else if store = x"4a" then  ----Backward right j
		i := 0;
		j := 0;
		k := 0;	
		l := 0;
		n := 0;
		m := 0;
		q := 0;
		p := p + 1;
		
		if p <= 1005000 then
			righ <= '0';
			lef <= '0';
			fw <= 0;
			rw <= 0;
		else if p > 1005000 and p < 1550000 then
			righ <= '1';
			lef <= '0';
			fw <= '0';
			rw <= '1';
		else if p = 1550000 then
			p := 0;
		end if;

	else if store = x"48" then  ----Backward Left H
		i := 0;
		j := 0;
		k := 0;	
		l := 0;
		n := 0;
		m := 0;
		p := 0;
		q := q + 1;
		
		if q <= 1005000 then
			righ <= '0';
			lef <= '0';
			fw <= 0;
			rw <= 0;
		else if q > 1005000 and q < 1550000 then
			righ <= '0';
			lef <= '1';
			fw <= '0';
			rw <= '1';
		else if q = 1550000 then
			q := 0;
		end if;

	else if store = x"53" then
		i := 0;
		j := 0;
		i := 0;
		k := 0;
		l := 0;
		m := 0;
		n := 0;
		p := 0;
		q := 0;
		fw <= '0';
		rw <= '0';
		righ <= '0';
		lef <= '0';
	else
			null;
	end if;
end if;
end process;

end Behavioral;











