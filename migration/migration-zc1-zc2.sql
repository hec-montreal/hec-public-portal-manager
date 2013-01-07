SET SERVEROUTPUT ON;
DECLARE
  CURSOR course_cur is
    SELECT coursecode, courseurl FROM ct_heccours3
      WHERE TO_CHAR(courseurl) like 'http://zonecours.hec.ca%'
      FOR UPDATE OF courseurl;

  v_course_code VARCHAR2(50);
  v_course_url CLOB;
  v_new_url VARCHAR2(200);
BEGIN
  OPEN course_cur;
  LOOP
    FETCH course_cur INTO v_course_code, v_course_url;
    EXIT WHEN course_cur%NOTFOUND;

    v_new_url := 'http://zonecours2.hec.ca/portail/?FR';
-- dans les donnees de dev, il y a plein de liens pour des cours anglophones qui n'ont pas le parametre de langue dans l'url (tout sauf un)
-- vu que c'est juste pour l'interface du portail je ne pense pas que ce soit necessaire, mais voici le code.
--    IF INSTR(v_course_url, 'lang=en') > 0 THEN
--      v_new_url := v_new_url || '?EN';
--    END IF;
    v_new_url := v_new_url || '#cours=' || v_course_code;
    
    -- output
    DBMS_OUTPUT.put_line(v_course_code);
    DBMS_OUTPUT.put_line(v_course_url);
    DBMS_OUTPUT.put_line(v_new_url);

    UPDATE ct_heccours3
      SET courseurl = v_new_url
      WHERE CURRENT OF course_cur;
  END LOOP;
  CLOSE course_cur;
  COMMIT;
END;