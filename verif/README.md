# 📝 How to Initialize the Instruction Memory

1. Create a file named `instructions.txt` in the same directory as the [`assembler.py`](assembler.py) script.

2. Write the instructions you want to include in the instruction memory in the file, with each instruction on a separate line.
    - Instructions must be written in RISC-V assembly. Refer to [`assembler.py`](assembler.py) for supported formats.

3. Open your terminal and execute the following command:
    ```shell
    python3 assembler.py
    ```

4. A file named `instruction.mif` should be generated in the same directory as the script.

# 🧪 How to Test Your Program with the Testbench

1. Create a new project in ModelSim.

2. Add all the files from the design folder to the project.

3. Include the testbench file [`tb_top.sv`](tb_top.sv) in the project.

4. In the project directory, ensure that you have the following files:
    - [compile_verilog](compile_verilog)
    - [runtb_top](runtb_top)
    - instruction.mif
    - data.mif

   Adjust the file paths in the scripts accordingly.

5. In the ModelSim terminal, execute the following command:
    ```shell
    do runtb_top
    ```

6. The compilation and simulation process will commence, and the results will be displayed in the terminal.
