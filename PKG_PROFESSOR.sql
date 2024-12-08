CREATE OR REPLACE PACKAGE PKG_PROFESSOR AS
    -- Cursor para total de turmas por professor
    CURSOR c_total_turmas_por_professor IS
        SELECT P.NOME, COUNT(C.ID_CURSO) AS total_turmas
        FROM PROFESSOR P
        JOIN CURSO C ON P.ID_PROFESSOR = C.ID_PROFESSOR
        GROUP BY P.NOME
        HAVING COUNT(C.ID_CURSO) > 1;

    -- Function para total de turmas de um professor
    FUNCTION total_turmas_por_professor(p_id_professor IN NUMBER) RETURN NUMBER;

    -- Function para professor de uma disciplina
    FUNCTION professor_de_disciplina(p_id_disciplina IN NUMBER) RETURN VARCHAR2;
END PKG_PROFESSOR;

/


CREATE OR REPLACE PACKAGE BODY PKG_PROFESSOR AS

    -- Implementação da Function para total de turmas de um professor
    FUNCTION total_turmas_por_professor(p_id_professor IN NUMBER) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_total
        FROM CURSO
        WHERE ID_PROFESSOR = p_id_professor;
        RETURN v_total;
    END total_turmas_por_professor;

    -- Implementação da Function para professor de uma disciplina
    FUNCTION professor_de_disciplina(p_id_disciplina IN NUMBER) RETURN VARCHAR2 IS
        v_nome_professor VARCHAR2(100);
    BEGIN
        SELECT P.NOME INTO v_nome_professor
        FROM PROFESSOR P
        JOIN CURSO C ON P.ID_PROFESSOR = C.ID_PROFESSOR
        WHERE C.ID_CURSO = p_id_disciplina;
        RETURN v_nome_professor;
    END professor_de_disciplina;

END PKG_PROFESSOR;

/
