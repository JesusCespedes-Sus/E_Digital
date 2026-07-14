TARGET = Raiz_TOP
TB = $(TARGET)_TB

OBJS = \
	Reg_A.v \
	Reg_Rs.v \
	Reg_Raiz.v \
	Reg_i.v \
	Rest_i.v \
	Check_i.v \
	Shift_Rs.v \
	Araiz_shift.v \
	RS_conc.v \
	Tmp.v \
	comp.v \
	Rsfin.v \
	Raizfin.v \
	MuxRs.v \
	MuxRaiz.v \
	Control_Raiz.v \
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