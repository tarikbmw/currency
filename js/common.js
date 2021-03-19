window.addEventListener('DOMContentLoaded', () =>
{
    let source = document.getElementById('source'),
        target = document.getElementById('target'),
        ratio = document.getElementById('ratio'),
        amount = document.getElementById('amount'),
        result = document.getElementById('result');



    const calculate = (source, target, ratio, amount, result) =>
    {
        let getCurrency = source => source.options[source.selectedIndex].getAttribute('currency');

        let cur1 = getCurrency(source),
            cur2 = getCurrency(target);

        ratioValue = cur1 / cur2;
        ratio.value = ratioValue;
        result.value = amount.value * ratioValue;
    };

    source.addEventListener('change', event => calculate(source,target,ratio,amount,result));
    target.addEventListener('change', event => calculate(source,target,ratio,amount,result));
    amount.addEventListener('keyup', event =>
    {
        let tm  = setTimeout(()=>
        {
            calculate(source,target,ratio,amount,result);
            clearTimeout(tm);
        }, 100);
    });

    calculate(source,target,ratio,amount,result);
});