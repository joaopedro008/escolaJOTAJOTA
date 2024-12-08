CREATE OR REPLACE PACKAGE PKG_ALUNO AS
    -- Procedure para exclusão de aluno e suas matrículas
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER);

    -- Cursor para listar alunos maiores de 18 anos
    CURSOR c_alunos_maiores_de_18 IS
        SELECT NOME, DATA_NASCIMENTO
        FROM ALUNO
        WHERE DATA_NASCIMENTO <= ADD_MONTHS(SYSDATE, -12*18);

    -- Cursor para listar alunos de um curso
    CURSOR c_alunos_por_curso(p_id_curso IN NUMBER) IS
        SELECT A.NOME
        FROM ALUNO A
        JOIN MATRICULA M ON A.ID_ALUNO = M.ID_ALUNO
        WHERE M.ID_DISCIPLINA IN (SELECT ID_DISCIPLINA FROM CURSO WHERE ID_CURSO = p_id_curso);
END PKG_ALUNO;

/


CREATE OR REPLACE PACKAGE BODY PKG_ALUNO AS

    -- Implementação da Procedure para exclusão de aluno
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER) IS
    BEGIN
        DELETE FROM MATRICULA WHERE ID_ALUNO = p_id_aluno;
        DELETE FROM ALUNO WHERE ID_ALUNO = p_id_aluno;
    END excluir_aluno;

END PKG_ALUNO;

/
