const calculateLoan = () => {
    let amount = document.getElementById("amount").value;
    let interest = document.getElementById("interest").value;
    let months = document.getElementById("months").value;
    
    let monthlyPayment = ((amount / months) + interest);
    let totalInterest = (amount * (interest * 0.01)) / months;
    let totalPayment = parseFloat(amount) + parseFloat(totalInterest);
    
    document.getElementById("calculator-result").innerHTML = `
                    <div>
                    <span><strong>Total payment </strong> <em> ${parseFloat(totalPayment).toFixed(2)}</em></span> 
                    <span><strong>Monthly Payment </strong><em> ${parseFloat(monthlyPayment).toFixed(2)}</em></span> 
                    <span><strong>Total Interest </strong><em class="total-last-child"> ${parseFloat(totalInterest).toFixed(2)}</em></span> </div>`;
}