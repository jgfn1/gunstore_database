--48. Bloco anônimo com declaração de variável e instrução
DECLARE
  bomb_number INTEGER := 0;
BEGIN
    SELECT artifact_code INTO bomb_number FROM artifacts
    WHERE name = 'C-4';
END;