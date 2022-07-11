-- sg library

-- pragma translate_off

library ieee;
use ieee.std_logic_1164.all;

-- flip-flop
entity dff_sg is
	port (
		D : in std_ulogic;
		CP : in std_ulogic;
		Q : out std_ulogic
	);
end;

architecture behav of dff_sg is
begin
	reg : process (CP)
	begin
		if rising_edge(CP) then 
			Q <= D;
		end if;
	end process;
end;

library ieee;
use ieee.std_logic_1164.all;

-- inv x1
entity inv_x1_sg is
	port (
		A : in std_ulogic;
		X : out std_ulogic
	);
end;

architecture behav of inv_x1_sg is
begin
	X <= not A;
end;


library ieee;
use ieee.std_logic_1164.all;

-- nand x1
entity nand_x1_sg is
	port (
		A : in std_ulogic;
		B : in std_ulogic;
		X : out std_ulogic
	);
end;

architecture behav of nand_x1_sg is
begin
	X <= not (A and B);
end;


library ieee;
use ieee.std_logic_1164.all;

-- nor x1
entity nor_x1_sg is
	port (
		A : in std_ulogic;
		B : in std_ulogic;
		X : out std_ulogic
	);
end;

architecture behav of nor_x1_sg is
begin
	X <= not (A or B);
end;

library ieee;
use ieee.std_logic_1164.all;

-- inv x2
entity inv_x2_sg is
	port (
		A : in std_ulogic;
		X : out std_ulogic
	);
end;

architecture behav of inv_x2_sg is
begin
	X <= not A;
end;

library ieee;
use ieee.std_logic_1164.all;

-- nand x2
entity nand_x2_sg is
	port (
		A : in std_ulogic;
		B : in std_ulogic;
		X : out std_ulogic
	);
end;

architecture behav of nand_x2_sg is
begin
	X <= not (A and B);
end;

library ieee;
use ieee.std_logic_1164.all;

-- nor x2
entity nor_x2_sg is
	port (
		A : in std_ulogic;
		B : in std_ulogic;
		X : out std_ulogic
	);
end;

architecture behav of nor_x2_sg is
begin
	X <= not (A or B);
end;

library ieee;
use ieee.std_logic_1164.all;

-- inv x4
entity inv_x4_sg is
	port (
		A : in std_ulogic;
		X : out std_ulogic
	);
end;

architecture behav of inv_x4_sg is
begin
	X <= not A;
end;

library ieee;
use ieee.std_logic_1164.all;

-- nand x4
entity nand_x4_sg is
	port (
		A : in std_ulogic;
		B : in std_ulogic;
		X : out std_ulogic
	);
end;

architecture behav of nand_x4_sg is
begin
	X <= not (A and B);
end;

library ieee;
use ieee.std_logic_1164.all;

-- nor x4
entity nor_x4_sg is
	port (
		A : in std_ulogic;
		B : in std_ulogic;
		X : out std_ulogic
	);
end;

architecture behav of nor_x4_sg is
begin
	X <= not (A or B);
end;


-- pragma translate_on
