create or replace noneditionable package pkg_transactions is

  -- Author  : KROVO
  -- Created : 26.11.2024 7:36:09
  -- Purpose : handle xml files

  function gen_xml_report(pdDateFrom date default to_date('23.11.2024',
                                                          
                                                          'dd.mm.yyyy'),
                          pdDateTo   date default to_date('26.11.2024',
                                                          'dd.mm.yyyy'))
    return xmltype;

end pkg_transactions;
/
create or replace noneditionable package body pkg_transactions is

  --Generatex xml report
  function gen_xml_report(pdDateFrom date default to_date('23.11.2024',
                                                          'dd.mm.yyyy'),
                          pdDateTo   date default to_date('26.11.2024',
                                                          'dd.mm.yyyy'))
    return xmltype is
    result xmltype;
  begin
    select xmlelement("transactions",
                      xmlagg(xmlelement("transaction",
                                        xmlforest(t.id as transaction_id,
                                                  xmlforest(c.id as client_id,
                                                            c.name,
                                                            c.surname) as
                                                  client,
                                                  case
                                                    when t.type = 0 then
                                                     'withdrawal'
                                                    else
                                                     'deposit'
                                                  end as type,
                                                  t.tran_sum as
                                                  transaction_sum,
                                                  t.tr_date as
                                                  transaction_date))))
      into result
      from sys.transactions t, sys.clients c
     where t.client_id = c.id
       and t.tr_date between pdDateFrom and pdDateTo;
    return result;
  end;
end;
/
