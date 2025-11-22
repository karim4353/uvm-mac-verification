# Minimal cocotb test (placeholder)
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer
@cocotb.test()
async def test_basic(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())
    dut.rst_n.value = 0
    await Timer(20, units="ns")
    dut.rst_n.value = 1
    await Timer(20, units="ns")
    # This is a small smoke: poke rx_valid and data a few cycles
    for i in range(4):
        dut.rx_valid.value = 1
        dut.rx_data.value = i
        dut.rx_last.value = 1 if i==3 else 0
        await RisingEdge(dut.clk)
    await Timer(50, units="ns")
