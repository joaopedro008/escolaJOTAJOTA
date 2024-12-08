CREATE OR REPLACE PACKAGE PKG_DISCIPLINA AS
    -- Procedure para cadastrar uma nova disciplina
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER);

    -- Cursor para total de alunos por disciplina
    CURSOR c_total_alunos_por_disciplina IS
        SELECT D.NOME, COUNT(M.ID_ALUNO) AS total_alunos
        FROM DISCIPLINA D
        LEFT JOIN MATRICULA M ON D.ID_DISCIPLINA = M.ID_DISCIPLINA
        GROUP BY D.NOME
        HAVING COUNT(M.ID_ALUNO) > 10;

    -- Cursor para média de idade dos alunos de uma disciplina
    CURSOR c_media_idade_por_disciplina(p_id_disciplina IN NUMBER) IS
        SELECT AVG(MONTHS_BETWEEN(SYSDATE, A.DATA_NASCIMENTO)/12) AS media_idade
        FROM ALUNO A
        JOIN MATRICULA M ON A.ID_ALUNO = M.ID_ALUNO
        WHERE M.ID_DISCIPLINA = p_id_disciplina;
END PKG_DISCIPLINA;

/


CREATE OR REPLACE PACKAGE BODY PKG_DISCIPLINA AS

    -- Procedure para cadastrar disciplina
    PROCEDURE CADASTRAR_DISCIPLINA(
        P_NOME IN VARCHAR2, 
        P_DESCRICAO IN VARCHAR2, 
        P_CARGA_HORARIA IN NUMBER
    ) IS
    BEGIN
        INSERT INTO DISCIPLINA (NOME, DESCRICAO, CARGA_HORARIA)
        VALUES (P_NOME, P_DESCRICAO, P_CARGA_HORARIA);
        COMMIT;
    END CADASTRAR_DISCIPLINA;

    -- Cursor para listar disciplinas com mais de 10 alunos
    PROCEDURE LISTAR_DISCIPLINAS_MAIS_10_ALUNOS IS
        CURSOR C_DISCIPLINAS IS
        SELECT D.NOME, COUNT(M.ID_ALUNO) AS TOTAL_ALUNOS
        FROM DISCIPLINA D
        JOIN MATRICULA M ON D.ID_DISCIPLINA = M.ID_DISCIPLINA
        GROUP BY D.NOME
        HAVING COUNT(M.ID_ALUNO) > 10;
    BEGIN
        FOR R_DISCIPLINA IN C_DISCIPLINAS LOOP
            DBMS_OUTPUT.PUT_LINE('Disciplina: ' || R_DISCIPLINA.NOME || ', Total de Alunos: ' || R_DISCIPLINA.TOTAL_ALUNOS);
        END LOOP;
    END LISTAR_DISCIPLINAS_MAIS_10_ALUNOS;

    -- Procedure para calcular a média de idade dos alunos por disciplina
    PROCEDURE CALCULAR_MEDIA_IDADE(P_ID_DISCIPLINA IN NUMBER) IS
        V_MEDIA_IDADE NUMBER;
        CURSOR C_MEDIA_IDADE IS
        SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, A.DATA_NASC) / 12)) AS MEDIA_IDADE
        FROM ALUNO A
        JOIN MATRICULA M ON A.ID_ALUNO = M.ID_ALUNO
        WHERE M.ID_DISCIPLINA = P_ID_DISCIPLINA;
    BEGIN
        OPEN C_MEDIA_IDADE;
        FETCH C_MEDIA_IDADE INTO V_MEDIA_IDADE;
        CLOSE C_MEDIA_IDADE;

        IF V_MEDIA_IDADE IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Média de idade dos alunos: ' || V_MEDIA_IDADE);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Nenhum aluno encontrado para a disciplina.');
        END IF;
    END CALCULAR_MEDIA_IDADE;

    -- Procedure para listar alunos de uma disciplina
    PROCEDURE LISTAR_ALUNOS_DISCIPLINA(P_ID_DISCIPLINA IN NUMBER) IS
        CURSOR C_ALUNOS_DISCIPLINA IS
        SELECT A.NOME
        FROM ALUNO A
        JOIN MATRICULA M ON A.ID_ALUNO = M.ID_ALUNO
        WHERE M.ID_DISCIPLINA = P_ID_DISCIPLINA;
    BEGIN
        FOR R_ALUNO IN C_ALUNOS_DISCIPLINA LOOP
            DBMS_OUTPUT.PUT_LINE('Aluno: ' || R_ALUNO.NOME);
        END LOOP;
    END LISTAR_ALUNOS_DISCIPLINA;

END PKG_DISCIPLINA;
/
