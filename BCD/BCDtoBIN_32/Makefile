TARGET = BCDBIN_TOP
TB = $(TARGET)_TB

OBJS = \
	Reg_B.v \
	Reg_h.v \
	Reg_i.v \
	cont.v \
	comp.v \
	decdig.v \
	decdig_c.v \
	decs.v \
	decB2.v \
	Control_bcdbin.v \
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