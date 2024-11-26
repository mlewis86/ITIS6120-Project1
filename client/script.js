

// Handle signup form submission
document.getElementById('signup-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    const username = document.getElementById('username').value;
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const role = document.getElementById('role').value;

    try {
        const response = await fetch('http://localhost:3000/auth/signup', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username, email, password, role }),
        });

        const data = await response.json();
        console.log('Response:', data);
        if (response.ok) {
            alert('User registered successfully!');
        } else {
            alert(data.error || 'Signup failed.');
        }
    } catch (err) {
        console.error('Error:', err);
        alert('An error occurred.');
    }
});

// Handle login form submission
document.getElementById('login-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    const username = document.getElementById('login-email').value;
    const password = document.getElementById('login-password').value;

    try {
        const response = await fetch('http://localhost:3000/auth/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username, password })
        });

        const data = await response.json();
        if (response.ok && data.token) {
            localStorage.setItem('token', data.token); // Store token in localStorage
            alert('Login successful!');
            window.location.href = 'dashboard.html'; // Redirect to the dashboard or home page
        } else {
            alert(data.error || 'Invalid credentials');
        }
    } catch (err) {
        console.error('Error:', err);
        alert('An error occurred.');
    }
});

