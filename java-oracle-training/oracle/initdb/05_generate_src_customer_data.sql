ALTER SESSION SET CONTAINER = FREEPDB1;
ALTER SESSION SET CURRENT_SCHEMA = SYSTEM;
ALTER SESSION SET NLS_LENGTH_SEMANTICS = CHAR;

DECLARE
    v_customer_id   NUMBER;
    v_name          VARCHAR2(100 CHAR);
    v_address       VARCHAR2(200 CHAR);
    v_type_id       VARCHAR2(3 CHAR);
    v_del           NUMBER(1);

    C_TOTAL         CONSTANT NUMBER := 3215;
    C_INVALID_START CONSTANT NUMBER := 3001;

    -- 変換可能なSOURCE_TYPE（9種類）
    TYPE t_types IS TABLE OF VARCHAR2(3 CHAR);
    v_types_ok t_types := t_types('001','010','100','002','020','200','003','030','300');

    -- 変換不能なSOURCE_TYPE
    v_types_ng t_types := t_types('999','998','997');

    TYPE t_names IS TABLE OF VARCHAR2(30 CHAR);
    v_names t_names := t_names(
        '田中太郎','鈴木花子','佐藤一郎','山田次郎','伊藤三郎',
        '渡辺四郎','中村五郎','小林六郎','加藤七郎','吉田八郎',
        '山本九郎','松本十郎','井上一花','木村二花','林三花',
        '清水四花','山崎五花','池田六花','橋本七花','石川八花'
    );

    TYPE t_cities IS TABLE OF VARCHAR2(50 CHAR);
    v_cities t_cities := t_cities(
        '東京都新宿区西新宿1-1-1','大阪府大阪市北区梅田2-2-2',
        '愛知県名古屋市中区栄3-3-3','福岡県福岡市博多区博多駅前4-4-4',
        '北海道札幌市中央区大通西5-5-5','神奈川県横浜市西区みなとみらい6-6-6',
        '京都府京都市中京区四条通7-7-7','兵庫県神戸市中央区三宮8-8-8',
        '広島県広島市中区紙屋町9-9-9','宮城県仙台市青葉区一番町10-10-10'
    );

BEGIN
    FOR i IN 1 .. C_TOTAL LOOP
        v_customer_id := i;
        v_name        := v_names(MOD(i - 1, v_names.COUNT) + 1) || i;
        v_address     := v_cities(MOD(i - 1, v_cities.COUNT) + 1);
        v_del         := CASE WHEN MOD(i, 20) = 0 THEN 1 ELSE 0 END;

        IF i >= C_INVALID_START THEN
            -- 変換不能データ（215件）
            v_type_id := v_types_ng(MOD(i - C_INVALID_START, v_types_ng.COUNT) + 1);
        ELSE
            -- 正常データ：9種類を循環
            v_type_id := v_types_ok(MOD(i - 1, v_types_ok.COUNT) + 1);
        END IF;

        INSERT INTO SRC_CUSTOMER (
            CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, CUSTOMER_TYPE_ID,
            DELETE_FLAG, CREATED_BY, CREATED_AT, UPDATED_BY, UPDATED_AT
        ) VALUES (
            v_customer_id,
            v_name,
            v_address,
            v_type_id,
            v_del,
            'SYSTEM',
            TRUNC(SYSDATE) - MOD(i, 365),
            'SYSTEM',
            TRUNC(SYSDATE) - MOD(i, 30)
        );

        IF MOD(i, 500) = 0 THEN
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('SRC_CUSTOMER: ' || i || '件コミット済');
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('SRC_CUSTOMER 完了: ' || C_TOTAL || '件');
END;
/
