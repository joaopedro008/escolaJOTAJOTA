CREATE OR REPLACE PACKAGE PKG_ALUNO AS
    PROCEDURE EXCLUIR_ALUNO(p_id_aluno IN NUMBER);
    PROCEDURE LISTAR_ALUNOS_MAIORIDADE;
    PROCEDURE LISTAR_ALUNOS_POR_DISCIPLINA(p_id_disciplina IN NUMBER);  -- Alterado de "curso" para "disciplina"
END PKG_ALUNO;

/


CREATE OR REPLACE PACKAGE BODY PKG_ALUNO AS

    -- Procedure de Exclusão de Aluno
    PROCEDURE EXCLUIR_ALUNO(p_id_aluno IN NUMBER) IS
    BEGIN
        DELETE FROM MATRICULA WHERE ID_ALUNO = p_id_aluno;
        DELETE FROM ALUNO WHERE ID_ALUNO = p_id_aluno;
        COMMIT;
    END EXCLUIR_ALUNO;

    -- Procedure de Listagem de Alunos Maiores de 18 anos
    PROCEDURE LISTAR_ALUNOS_MAIORIDADE IS
        CURSOR c_alunos IS
            SELECT NOME, DATA_NASCIMENTO
            FROM ALUNO
            WHERE DATA_NASCIMENTO <= ADD_MONTHS(SYSDATE, -18*12);
        r_aluno c_alunos%ROWTYPE;
    BEGIN
        OPEN c_alunos;
        LOOP
            FETCH c_alunos INTO r_aluno;
            EXIT WHEN c_alunos%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Aluno: ' || r_aluno.NOME || ', Nascimento: ' || r_aluno.DATA_NASCIMENTO);
        END LOOP;
        CLOSE c_alunos;
    END LISTAR_ALUNOS_MAIORIDADE;

    -- Procedure de Listagem de Alunos por Disciplina (ajustado)
    PROCEDURE LISTAR_ALUNOS_POR_DISCIPLINA(p_id_disciplina IN NUMBER) IS
        CURSOR c_alunos_disciplina IS
            SELECT A.NOME
            FROM ALUNO A
            JOIN MATRICULA M ON A.ID_ALUNO = M.ID_ALUNO
            WHERE M.ID_DISCIPLINA = p_id_disciplina;  -- Usando ID_DISCIPLINA em vez de ID_CURSO
        r_aluno c_alunos_disciplina%ROWTYPE;
    BEGIN
        OPEN c_alunos_disciplina;
        LOOP
            FETCH c_alunos_disciplina INTO r_aluno;
            EXIT WHEN c_alunos_disciplina%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Aluno: ' || r_aluno.NOME);
        END LOOP;
        CLOSE c_alunos_disciplina;
    END LISTAR_ALUNOS_POR_DISCIPLINA;

END PKG_ALUNO;

/
