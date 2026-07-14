ALTER SESSION SET CONTAINER = FREEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = SYSTEM;
ALTER SESSION SET NLS_LENGTH_SEMANTICS = CHAR;
-- ============================================================
-- Part3: SRC_BILLING 20,089件 / SRC_BILLING_DETAIL 60,157件生成
-- SRC_BILLINGはSRC_CONTRACTの範囲内（1〜5143）でFKを保持
-- SRC_BILLING_DETAILはSRC_BILLINGの範囲内でFKを保持
-- ITEM_TYPE: 'ELECTRIC','GAS','SUNLIGHT','EV'
-- ============================================================

-- ============================================================
-- Step1: SRC_BILLING 20,089件
-- ============================================================
DECLARE
    C_TOTAL      CONSTANT NUMBER := 20089;
    C_CONTRACT   CONSTANT NUMBER := 5143;

    TYPE t_months IS TABLE OF VARCHAR2(6 CHAR);
    v_months t_months := t_months(
        '202401','202402','202403','202404','202405','202406',
        '202407','202408','202409','202410','202411','202412',
        '202501','202502','202503','202504','202505','202506'
    );

    v_contract_id  NUMBER;
    v_bill_month   VARCHAR2(6 CHAR);
    v_total        NUMBER(10,2);
    v_del          NUMBER(1);
BEGIN
    FOR i IN 1 .. C_TOTAL LOOP
        v_contract_id := MOD(i - 1, C_CONTRACT) + 1;
        v_bill_month  := v_months(MOD(i - 1, v_months.COUNT) + 1);
        v_total       := ROUND((MOD(i * 7, 50000) + 1000) + (MOD(i, 100) * 0.5), 2);
        v_del         := CASE WHEN MOD(i, 50) = 0 THEN 1 ELSE 0 END;

        INSERT INTO SRC_BILLING (
            BILLING_ID, CONTRACT_ID, BILL_MONTH, TOTAL_AMOUNT,
            DELETE_FLAG, CREATED_BY, CREATED_AT, UPDATED_BY, UPDATED_AT
        ) VALUES (
            i,
            v_contract_id,
            v_bill_month,
            v_total,
            v_del,
            'SYSTEM',
            TRUNC(SYSDATE) - MOD(i, 365),
            'SYSTEM',
            TRUNC(SYSDATE) - MOD(i, 30)
        );

        IF MOD(i, 1000) = 0 THEN
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('SRC_BILLING: ' || i || '件コミット済');
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SRC_BILLING 完了: ' || C_TOTAL || '件');
END;
/

-- ============================================================
-- Step2: SRC_BILLING_DETAIL 60,157件
-- 1請求につき平均3明細（BILLINGのIDを循環させてFK整合性を保持）
-- ============================================================
DECLARE
    C_TOTAL    CONSTANT NUMBER := 60157;
    C_BILLING  CONSTANT NUMBER := 20089;

    TYPE t_item IS TABLE OF VARCHAR2(50 CHAR);
    v_items t_item := t_item('ELECTRIC', 'GAS', 'SUNLIGHT', 'EV');

    v_billing_id  NUMBER;
    v_item_type   VARCHAR2(50 CHAR);
    v_usage       NUMBER(10,2);
    v_unit        NUMBER(10,2);
    v_amount      NUMBER(10,2);
    v_del         NUMBER(1);
BEGIN
    FOR i IN 1 .. C_TOTAL LOOP
        v_billing_id := MOD(i - 1, C_BILLING) + 1;
        v_item_type  := v_items(MOD(i - 1, v_items.COUNT) + 1);
        v_usage      := ROUND(MOD(i * 3, 500) + 10 + (MOD(i, 10) * 0.1), 2);
        v_unit       := CASE v_item_type
                            WHEN 'ELECTRIC' THEN ROUND(27 + MOD(i, 5) * 0.1, 2)
                            WHEN 'GAS'      THEN ROUND(180 + MOD(i, 10) * 0.5, 2)
                            WHEN 'SUNLIGHT' THEN ROUND(10 + MOD(i, 3) * 0.2, 2)
                            WHEN 'EV'       THEN ROUND(30 + MOD(i, 7) * 0.3, 2)
                            ELSE 0
                        END;
        v_amount     := ROUND(v_usage * v_unit, 2);
        v_del        := CASE WHEN MOD(i, 100) = 0 THEN 1 ELSE 0 END;

        INSERT INTO SRC_BILLING_DETAIL (
            BILLING_DETAIL_ID, BILLING_ID, ITEM_TYPE,
            USAGE_QTY, UNIT_PRICE, AMOUNT,
            DELETE_FLAG, CREATED_BY, CREATED_AT, UPDATED_BY, UPDATED_AT
        ) VALUES (
            i,
            v_billing_id,
            v_item_type,
            v_usage,
            v_unit,
            v_amount,
            v_del,
            'SYSTEM',
            TRUNC(SYSDATE) - MOD(i, 365),
            'SYSTEM',
            TRUNC(SYSDATE) - MOD(i, 30)
        );

        IF MOD(i, 2000) = 0 THEN
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('SRC_BILLING_DETAIL: ' || i || '件コミット済');
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SRC_BILLING_DETAIL 完了: ' || C_TOTAL || '件');
END;
/
