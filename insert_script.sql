begin
    for i in 1..100 loop
        insert into clients
        values (sq_clients.nextval, dbms_random.string('a',10), dbms_random.string('a',20));
    end loop;
end;


begin
    for i in 1..100 loop
        insert into transactions
        values (sq_transactions.nextval, round(dbms_random.value(1,100)),
                round(dbms_random.value(low => 0, high => 1)), dbms_random.value(low => 1, high => 10000), sysdate-100+dbms_random.value(low => 0, high => 100));
    end loop;
end;
