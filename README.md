# MIPS-Processor

# 🚀 MIPS Pipelined Processor (Verilog HDL)

This repository contains a **basic MIPS pipelined processor design** implemented in **Verilog HDL**. It currently supports **Program Counter (PC) management** and **verification of two MIPS instructions**, serving as the foundation for a fully functional pipelined architecture.

---

## 🧠 Project Overview

This project demonstrates the initial stages of a **5-stage pipelined MIPS processor**, focusing on:

- ✅ Program Counter (PC) update logic
- ✅ Instruction Fetch and Decode
- ✅ Verification of two MIPS instructions
- 🚧 Placeholder stages for Execute, Memory, and Writeback

The pipeline stages are modular, and additional instructions and features will be added incrementally as development progresses.

---

## 🔍 Current Features

- 🔁 **Program Counter** logic implemented
- 📥 **Instruction Fetch** module with ROM
- 🔄 **Instruction Decode** logic for:
  - **ADD** (R-type)
  - **SUB** (R-type)
- ✅ Pipeline register placeholders included for future expansion
- 🧪 Testbench verifies correct instruction fetch and basic decode

---

## 🏗️ Pipeline Architecture (Work-in-Progress)

[IF] → [ID] → [EX] → [MEM] → [WB]

# PC update waveform

<img width="1366" height="768" alt="Screenshot (239)" src="https://github.com/user-attachments/assets/1587a116-5bda-4ce9-a23a-0a7a4e788640" />

# Instruction verification

<img width="1366" height="768" alt="Screenshot (240)" src="https://github.com/user-attachments/assets/3a5a6f54-6e9c-4561-b3ad-a294e9ea591a" />
<img width="1366" height="768" alt="Screenshot (241)" src="https://github.com/user-attachments/assets/572a72cd-dad5-40ac-9a27-3eaf955b8b4c" />

