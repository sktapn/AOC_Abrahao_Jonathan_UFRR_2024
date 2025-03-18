library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Processador is
    Port (
        clk         : in  STD_LOGIC; -- Clock global
        reset       : in  STD_LOGIC; -- Sinal de reset
        -- Saídas para depuração (opcional)
        pc_out      : out STD_LOGIC_VECTOR(7 downto 0); -- Saída do PC
        instrucao_out : out STD_LOGIC_VECTOR(7 downto 0); -- Instrução atual
        reg1_out    : out STD_LOGIC_VECTOR(7 downto 0); -- Saída do registrador 1
        reg2_out    : out STD_LOGIC_VECTOR(7 downto 0); -- Saída do registrador 2
        ula_out     : out STD_LOGIC_VECTOR(7 downto 0); -- Saída da ULA
        ram_out     : out STD_LOGIC_VECTOR(7 downto 0)  -- Saída da RAM
    );
end Processador;

architecture Behavioral of Processador is
    -- Sinais internos para interconexão
    signal pc_ender        : STD_LOGIC_VECTOR(7 downto 0); -- Endereço do PC
    signal instrucao       : STD_LOGIC_VECTOR(7 downto 0); -- Instrução lida da ROM
    signal opcode          : STD_LOGIC_VECTOR(2 downto 0); -- Opcode decodificado
    signal rd              : STD_LOGIC_VECTOR(1 downto 0); -- Registrador de destino
    signal rs              : STD_LOGIC_VECTOR(1 downto 0); -- Registrador de origem
    signal imm             : STD_LOGIC_VECTOR(2 downto 0); -- Valor imediato
    signal jump5           : STD_LOGIC_VECTOR(4 downto 0); -- Endereço de salto
    signal reg_write       : STD_LOGIC; -- Sinal de escrita no banco de registradores
    signal mem_write       : STD_LOGIC; -- Sinal de escrita na memória
    signal branch          : STD_LOGIC; -- Sinal de branch
    signal jump            : STD_LOGIC; -- Sinal de jump
    signal alu_op          : STD_LOGIC_VECTOR(2 downto 0); -- Operação da ULA
    signal read_data1      : STD_LOGIC_VECTOR(7 downto 0); -- Dado lido do registrador 1
    signal read_data2      : STD_LOGIC_VECTOR(7 downto 0); -- Dado lido do registrador 2
    signal ula_result      : STD_LOGIC_VECTOR(7 downto 0); -- Resultado da ULA
    signal ram_data_out    : STD_LOGIC_VECTOR(7 downto 0); -- Dado lido da RAM
    signal mux_ula_b       : STD_LOGIC_VECTOR(7 downto 0); -- Saída do MUX para a ULA
    signal mux_ram_data    : STD_LOGIC_VECTOR(7 downto 0); -- Saída do MUX para a RAM
    signal mux_pc          : STD_LOGIC_VECTOR(7 downto 0); -- Saída do MUX para o PC
    signal pc_load         : STD_LOGIC; -- Sinal de carga do PC
    signal pc_inc          : STD_LOGIC; -- Sinal de incremento do PC
    signal endereco_ram    : STD_LOGIC_VECTOR(7 downto 0); -- Endereço da RAM
    signal read_reg1       : STD_LOGIC_VECTOR(2 downto 0); -- Endereço do registrador 1 (3 bits)
    signal read_reg2       : STD_LOGIC_VECTOR(2 downto 0); -- Endereço do registrador 2 (3 bits)
    signal write_reg       : STD_LOGIC_VECTOR(2 downto 0); -- Endereço do registrador de destino (3 bits)

begin
    -- Instanciação do PC
    pc_inst : entity work.PC
        port map (
            clk        => clk,
            branch     => branch,
            jump       => jump,
            alu_result => ula_result,
            imm        => imm,
            pc         => pc_ender
        );

    -- Instanciação da ROM
    rom_inst : entity work.ROM
        port map (
            addr  => pc_ender,
            instr => instrucao
        );

    -- Instanciação do decodificador
    decodificador_inst : entity work.Decodificador
        port map (
            instr   => instrucao,
            opcode  => opcode,
            rd      => rd,
            rs      => rs,
            imm     => imm,
            jump5   => jump5
        );

    -- Geração dos endereços de registradores (3 bits)
    read_reg1 <= "0" & rs; -- Concatenação para 3 bits
    read_reg2 <= "0" & rd; -- Concatenação para 3 bits
    write_reg <= "0" & rd; -- Concatenação para 3 bits

    -- Instanciação do banco de registradores
    banco_regs_inst : entity work.BancoRegistradores
        port map (
            clk      => clk,
            we       => reg_write,
            raddr1   => rs,
            raddr2   => rd,
            waddr    => rd,
            wdata    => mux_ram_data,
            rdata1   => read_data1,
            rdata2   => read_data2,
            r0_out   => open,
            r1_out   => open,
            r2_out   => open,
            r3_out   => open
        );

    -- Instanciação da ULA
    ula_inst : entity work.ULA
        port map (
            op     => alu_op,
            a      => read_data1,
            b      => mux_ula_b,
            result => ula_result
        );

    -- Instanciação da RAM
    ram_inst : entity work.RAM
        port map (
            clk  => clk,
            addr => endereco_ram,
            we   => mem_write,
            din  => read_data2,
            dout => ram_data_out
        );

    -- Instanciação do MUX para a ULA
    mux_ula_inst : entity work.MUX
        port map (
            InputA  => read_data2,
            InputB  => "00000" & imm, -- Concatenação para 8 bits
            Chave   => opcode(0), -- Seleção baseada no opcode
            Output  => mux_ula_b
        );

    -- Instanciação do MUX para a RAM
    mux_ram_inst : entity work.MUX
        port map (
            InputA  => ula_result,
            InputB  => ram_data_out,
            Chave   => mem_write,
            Output  => mux_ram_data
        );

    -- Instanciação da unidade de controle
    controle_inst : entity work.Control
        port map (
            opcode_3b => opcode,
            we_reg    => reg_write,
            we_mem    => mem_write,
            branch    => branch,
            jump      => jump,
            alu_op    => alu_op
        );

    -- Lógica de controle do PC
    pc_load <= '1' when opcode = "110" else '0'; -- Jump
    pc_inc  <= '1' when opcode /= "110" else '0'; -- Incrementa PC se não for jump

    -- Atribuição do endereço da RAM
    endereco_ram <= ula_result; -- Exemplo: usa o resultado da ULA como endereço da RAM

    -- Saídas para depuração
    pc_out <= pc_ender;
    instrucao_out <= instrucao;
    reg1_out <= read_data1;
    reg2_out <= read_data2;
    ula_out <= ula_result;
    ram_out <= ram_data_out;

end Behavioral;