ALTER SESSION SET CONTAINER = FREEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = SYSTEM;
ALTER SESSION SET NLS_LENGTH_SEMANTICS = CHAR;

DECLARE
    C_TOTAL         CONSTANT NUMBER := 5143;
    C_INVALID_START CONSTANT NUMBER := 4901;

    TYPE t_energy IS TABLE OF VARCHAR2(10 CHAR);
    v_energy_ok  t_energy := t_energy('ELECT', 'GAS', 'SUNLIGHT', 'EV');
    v_energy_ng  t_energy := t_energy('UNKNOWN', 'OTHER', '???', 'NONE', 'ERR');

    TYPE t_status IS TABLE OF VARCHAR2(20 CHAR);
    v_status t_status := t_status('ACTIVE', 'INACTIVE', 'PENDING', 'CANCELLED', 'EXPIRED');

    v_remark_long  VARCHAR2(200 CHAR) := RPAD('X', 200, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');

    TYPE t_short IS TABLE OF VARCHAR2(50 CHAR);
    v_remark_short t_short := t_short(
        'Web申込', '電話申込', '店舗申込',
        'A1023', 'B2045', 'C3067',
        'WINTER2025', 'SUMMER2024', 'SPRING2025',
        '2025-04-01予定', '2025-06-15予定',
        '通常', '重要', '法人',
        'スマートメーター', '旧式',
        '問題なし', 'トラブルあり',
        '100V', '200V'
    );

    v_customer_id  NUMBER;
    v_energy_type  VARCHAR2(10 CHAR);
    v_start_date   DATE;
    v_end_date     DATE;
    v_created_at   DATE;
    v_updated_at   DATE;
    v_del          NUMBER(1);
    v_is_long      NUMBER;
    v_status_val   VARCHAR2(20 CHAR);

    v_r1  VARCHAR2(200 CHAR); v_r2  VARCHAR2(200 CHAR); v_r3  VARCHAR2(200 CHAR);
    v_r4  VARCHAR2(200 CHAR); v_r5  VARCHAR2(200 CHAR); v_r6  VARCHAR2(200 CHAR);
    v_r7  VARCHAR2(200 CHAR); v_r8  VARCHAR2(200 CHAR); v_r9  VARCHAR2(200 CHAR);
    v_r10 VARCHAR2(200 CHAR); v_r11 VARCHAR2(200 CHAR); v_r12 VARCHAR2(200 CHAR);
    v_r13 VARCHAR2(200 CHAR); v_r14 VARCHAR2(200 CHAR); v_r15 VARCHAR2(200 CHAR);
    v_r16 VARCHAR2(200 CHAR); v_r17 VARCHAR2(200 CHAR); v_r18 VARCHAR2(200 CHAR);
    v_r19 VARCHAR2(200 CHAR); v_r20 VARCHAR2(200 CHAR);

BEGIN
    FOR i IN 1 .. C_TOTAL LOOP

        v_customer_id := MOD(i - 1, 3215) + 1;
        v_is_long     := MOD(i, 2);
        v_del         := CASE WHEN MOD(i, 30) = 0 THEN 1 ELSE 0 END;
        v_created_at  := TRUNC(SYSDATE) - MOD(i, 365);
        v_updated_at  := TRUNC(SYSDATE) - MOD(i, 30);
        v_status_val  := v_status(MOD(i - 1, v_status.COUNT) + 1);

        IF i >= C_INVALID_START THEN
            v_energy_type := v_energy_ng(MOD(i - C_INVALID_START, v_energy_ng.COUNT) + 1);
        ELSE
            v_energy_type := v_energy_ok(MOD(i - 1, v_energy_ok.COUNT) + 1);
        END IF;

        v_start_date := TRUNC(SYSDATE) - MOD(i, 1000);
        v_end_date   := CASE WHEN MOD(i, 5) = 0 THEN NULL ELSE v_start_date + 365 END;

        IF v_is_long = 1 THEN
            v_r1:=v_remark_long; v_r2:=v_remark_long; v_r3:=v_remark_long; v_r4:=v_remark_long;
            v_r5:=v_remark_long; v_r6:=v_remark_long; v_r7:=v_remark_long; v_r8:=v_remark_long;
            v_r9:=v_remark_long; v_r10:=v_remark_long; v_r11:=v_remark_long; v_r12:=v_remark_long;
            v_r13:=v_remark_long; v_r14:=v_remark_long; v_r15:=v_remark_long; v_r16:=v_remark_long;
            v_r17:=v_remark_long; v_r18:=v_remark_long; v_r19:=v_remark_long; v_r20:=v_remark_long;
        ELSE
            v_r1:=v_remark_short(MOD(0,v_remark_short.COUNT)+1);
            v_r2:=v_remark_short(MOD(1,v_remark_short.COUNT)+1);
            v_r3:=v_remark_short(MOD(2,v_remark_short.COUNT)+1);
            v_r4:=v_remark_short(MOD(3,v_remark_short.COUNT)+1);
            v_r5:=v_remark_short(MOD(4,v_remark_short.COUNT)+1);
            v_r6:=v_remark_short(MOD(5,v_remark_short.COUNT)+1);
            v_r7:=v_remark_short(MOD(6,v_remark_short.COUNT)+1);
            v_r8:=v_remark_short(MOD(7,v_remark_short.COUNT)+1);
            v_r9:=v_remark_short(MOD(8,v_remark_short.COUNT)+1);
            v_r10:=v_remark_short(MOD(9,v_remark_short.COUNT)+1);
            v_r11:=v_remark_short(MOD(10,v_remark_short.COUNT)+1);
            v_r12:=v_remark_short(MOD(11,v_remark_short.COUNT)+1);
            v_r13:=v_remark_short(MOD(12,v_remark_short.COUNT)+1);
            v_r14:=v_remark_short(MOD(13,v_remark_short.COUNT)+1);
            v_r15:=v_remark_short(MOD(14,v_remark_short.COUNT)+1);
            v_r16:=v_remark_short(MOD(15,v_remark_short.COUNT)+1);
            v_r17:=v_remark_short(MOD(16,v_remark_short.COUNT)+1);
            v_r18:=v_remark_short(MOD(17,v_remark_short.COUNT)+1);
            v_r19:=v_remark_short(MOD(18,v_remark_short.COUNT)+1);
            v_r20:=v_remark_short(MOD(19,v_remark_short.COUNT)+1);
        END IF;

        INSERT INTO SRC_CONTRACT (
            CONTRACT_ID, CUSTOMER_ID, ENERGY_TYPE, STATUS,
            START_DATE, END_DATE,
            REMARK1,  REMARK2,  REMARK3,  REMARK4,  REMARK5,
            REMARK6,  REMARK7,  REMARK8,  REMARK9,  REMARK10,
            REMARK11, REMARK12, REMARK13, REMARK14, REMARK15,
            REMARK16, REMARK17, REMARK18, REMARK19, REMARK20,
            DELETE_FLAG, CREATED_BY, CREATED_AT, UPDATED_BY, UPDATED_AT
        ) VALUES (
            i,
            v_customer_id,
            v_energy_type,
            v_status_val,
            v_start_date,
            v_end_date,
            v_r1,  v_r2,  v_r3,  v_r4,  v_r5,
            v_r6,  v_r7,  v_r8,  v_r9,  v_r10,
            v_r11, v_r12, v_r13, v_r14, v_r15,
            v_r16, v_r17, v_r18, v_r19, v_r20,
            v_del,
            'SYSTEM', v_created_at,
            'SYSTEM', v_updated_at
        );

        IF MOD(i, 500) = 0 THEN
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('SRC_CONTRACT: ' || i || '件コミット済');
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SRC_CONTRACT 完了: ' || C_TOTAL || '件');
END;
/
