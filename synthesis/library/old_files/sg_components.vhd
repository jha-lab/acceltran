-- sg library

library ieee;
use ieee.std_logic_1164.all;

package sg_components is

-- flip-flop
component dff_sg is
	port (
		D : in std_ulogic;
		CP : in std_ulogic;
		Q : out std_ulogic
	);
end component;

-- inv x1
component inv_x1_sg is
	port (
		A : in std_ulogic;
		X : out std_ulogic
	);
end component;

-- nand x1
component nand_x1_sg is
	port (
		A : in std_ulogic;
		B : in std_ulogic;
		X : out std_ulogic
	);
end component;

-- nor x1
component nor_x1_sg is
	port (
		A : in std_ulogic;
		B : in std_ulogic;
		X : out std_ulogic
	);
end component;

-- inv x2
component inv_x2_sg is
	port (
		A : in std_ulogic;
		X : out std_ulogic
	);
end component;

-- nand x2
component nand_x2_sg is
	port (
		A : in std_ulogic;
		B : in std_ulogic;
		X : out std_ulogic
	);
end component;

-- nor x2
component nor_x2_sg is
	port (
		A : in std_ulogic;
		B : in std_ulogic;
		X : out std_ulogic
	);
end component;

-- inv x4
component inv_x4_sg is
	port (
		A : in std_ulogic;
		X : out std_ulogic
	);
end component;

-- nand x4
component nand_x4_sg is
	port (
		A : in std_ulogic;
		B : in std_ulogic;
		X : out std_ulogic
	);
end component;

-- nor x4
component nor_x4_sg is
	port (
		A : in std_ulogic;
		B : in std_ulogic;
		X : out std_ulogic
	);
end component;

end;
