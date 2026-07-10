TARGET = Paridad_Top
TB = Paridad_Top_TB

OBJS = \
	Reg_A.v \
	Reg_B.v \
	Reg_i.v \
	Cont_i.v \
	Check_i.v \
	Par.v \
	Control_Paridad.v \
	Paridad_Top.v

all: sim

sim:
	rm -f a.out *.vcd
	iverilog -g2012 -o a.out $(TB).v $(OBJS)
	vvp a.out
	gtkwave $(TB).vcd &

compile:
	iverilog -g2012 -o a.out $(TB).v $(OBJS)

run:
	vvp a.out

wave:
	gtkwave $(TB).vcd &

clean:
	rm -f a.out *.vcd