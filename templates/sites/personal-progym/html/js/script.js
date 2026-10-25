$(function () {
    $('.nav-btn').on('click', function () {
        $(this).toggleClass('open');
    });
});

$(window).ready(function () {
    $(window).scroll(function () {
        var scroll = $(window).scrollTop();
        if (scroll > 100) {
            $("#header").addClass('glass-effect');
        } else {
            $("#header").removeClass("glass-effect");
        }
    })
})

// Menangani klik pada tombol filter untuk gender
const genderButtons = document.querySelectorAll('.gender-btn');
const genderInput = document.getElementById('gender');

genderButtons.forEach(button => {
    button.addEventListener('click', function () {
        // Menghapus kelas 'active' dari semua tombol
        genderButtons.forEach(btn => btn.classList.remove('active'));

        // Menambahkan kelas 'active' ke tombol yang dipilih
        this.classList.add('active');

        // Mengatur nilai input tersembunyi
        genderInput.value = this.getAttribute('data-gender');
    });
});

// Menangani submit form dan validasi gender
document.getElementById('bmiForm').addEventListener('submit', function (event) {
    if (!genderInput.value) {
        event.preventDefault(); // Mencegah form dikirim jika gender belum dipilih
        alert('Please select your gender');
    } else {
        // Validasi form lainnya dan perhitungan BMI bisa dimasukkan di sini
        const weight = parseFloat(document.getElementById('weight').value);
        const height = parseFloat(document.getElementById('height').value) / 100; // Mengubah cm ke meter

        if (isNaN(weight) || isNaN(height) || weight <= 0 || height <= 0) {
            alert('Please enter valid weight and height');
            return;
        }

        // Menghitung BMI
        const bmi = weight / (height * height);
        let category = '';
        if (bmi < 18.5) {
            category = 'Underweight';
        } else if (bmi >= 18.5 && bmi < 24.9) {
            category = 'Normal weight';
        } else if (bmi >= 25 && bmi < 29.9) {
            category = 'Overweight';
        } else {
            category = 'Obesity';
        }

        // Menampilkan hasil BMI
        document.getElementById('result').innerHTML = `Your BMI is ${bmi.toFixed(2)} (${category})`;
    }
});

