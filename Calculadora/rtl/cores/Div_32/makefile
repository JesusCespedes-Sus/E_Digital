TARGET = Div_TOP
TB = $(TARGET)_TB

OBJS = \
	Reg_A.v \
	Reg_Q.v \
	Reg_M.v \
	Div_Reg_i.v \
	Rest_i.v \
	Check_i.v \
	Check_A.v \
	ALU.v \
	Shift_AQ.v \
	MUX_A.v \
	MUX_Q.v \
	Control_div.v \
	peripheral_div.v \
	$(TARGET).v

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