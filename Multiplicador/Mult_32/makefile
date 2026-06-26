TARGET = Mul_Top
TB = Mul_Top_TB

OBJS = \
	Reg_A.v \
	Reg_D.v \
	Reg_C.v \
	Reg_i.v \
	Cont_i.v \
	Comp_Ai.v \
	Check_i.v \
	ADD_D.v \
	Control_mult.v \
	Mul_Top.v

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