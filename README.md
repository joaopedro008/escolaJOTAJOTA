# Sistema de Gestão de Alunos, Disciplinas e Professores

## Estrutura do Banco de Dados

O banco de dados tem as seguintes tabelas:

- **ALUNO**: Guarda informações sobre os alunos.
- **DISCIPLINA**: Armazena as disciplinas que a escola oferece.
- **MATRICULA**: Relaciona os alunos às disciplinas em que estão matriculados.
- **PROFESSOR**: Guarda os dados dos professores.
- **TURMA**: Relaciona os professores às disciplinas que lecionam.

Além dessas tabelas, o código também define pacotes PL/SQL que agrupam as funções para facilitar o gerenciamento dos dados.

## Como Executar os Scripts no Oracle

1. **Conectando ao banco de dados Oracle**:
   - Abra o Oracle SQL Developer ou qualquer outro cliente de banco de dados que você preferir.
   - Conecte-se ao banco de dados com suas credenciais.

2. **Criar as tabelas**:
   - Execute o script que cria as tabelas: `ALUNO`, `DISCIPLINA`, `MATRICULA`, `PROFESSOR`, e `TURMA`. Esse script cria a estrutura básica do banco de dados.

3. **Criar os pacotes PL/SQL**:
   - Execute os scripts para criar os pacotes `PKG_ALUNO`, `PKG_DISCIPLINA` e `PKG_PROFESSOR`. Esses pacotes contêm as procedures e funções para gerenciar os dados de alunos, disciplinas e professores.

4. **Testando as funcionalidades**:
   - Após rodar os scripts, você pode testar as funcionalidades inserindo dados ou executando as procedures e funções criadas nos pacotes. Experimente cadastrar alunos, matriculá-los, cadastrar disciplinas, e fazer consultas como a listagem de alunos maiores de 18 anos ou o número de turmas de cada professor.

## Descrição dos Pacotes

### Pacote PKG_ALUNO

- **Exclusão de aluno**: Exclui um aluno e todas as suas matrículas.
- **Listagem de alunos maiores de 18 anos**: Mostra os alunos com mais de 18 anos.
- **Listagem de alunos por curso**: Mostra os alunos matriculados em um curso específico.

### Pacote PKG_DISCIPLINA

- **Cadastro de disciplina**: Cadastra uma nova disciplina no sistema.
- **Total de alunos por disciplina**: Mostra o número de alunos matriculados em cada disciplina, mas só exibe disciplinas com mais de 10 alunos.
- **Média de idade por disciplina**: Calcula a média de idade dos alunos em uma disciplina específica.
- **Listagem de alunos de uma disciplina**: Mostra os alunos matriculados em uma disciplina.

### Pacote PKG_PROFESSOR

- **Total de turmas por professor**: Mostra os professores e o número de turmas que lecionam, mas só exibe professores com mais de uma turma.
- **Total de turmas de um professor**: Mostra o número de turmas de um professor, dado o seu ID.
- **Professor de uma disciplina**: Mostra o nome do professor responsável por uma disciplina.


