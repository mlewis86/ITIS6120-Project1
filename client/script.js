document.addEventListener('DOMContentLoaded', () => {
    // Elements that might be present on different pages
    const roleSpecificFields = document.getElementById('role-specific-fields');
    const content = document.getElementById('role-specific-content');

    // Load role-specific content if role is already stored
    const savedRole = localStorage.getItem('role');
    if (savedRole && content) {
        renderRoleSpecificContent(savedRole);
    }

    // Handle role change (on signup page)
    const roleSelect = document.getElementById('role');
    if (roleSelect) {
        roleSelect.addEventListener('change', function () {
            const role = this.value;
            if (roleSpecificFields) {
                roleSpecificFields.innerHTML = ''; // Clear previous fields
            }
            renderRoleSpecificContent(role);
        });
    }

    function renderRoleSpecificContent(role) {
        if (roleSpecificFields) {
            if (role === 'patient') {
                roleSpecificFields.innerHTML = `
                    <label for="medicalHistory">Medical History</label>
                    <textarea id="medicalHistory" name="medicalHistory" required></textarea>
                    <label for="emergencyContact">Emergency Contact</label>
                    <input type="text" id="emergencyContact" name="emergencyContact" required>
                `;
            } else if (role === 'doctor') {
                roleSpecificFields.innerHTML = `
                    <label for="specialization">Specialization</label>
                    <input type="text" id="specialization" name="specialization" required>
                    <label for="experience">Experience</label>
                    <input type="text" id="experience" name="experience" required>
                `;
            } else if (role === 'nurse') {
                roleSpecificFields.innerHTML = `
                    <label for="department">Department</label>
                    <input type="text" id="department" name="department" required>
                    <label for="shifts">Preferred Shifts</label>
                    <input type="text" id="shifts" name="shifts" required>
                `;
            } else {
                roleSpecificFields.innerHTML = ''; // Clear fields for general user
            }
        }

        if (content) {
            if (role === 'patient') {
                content.innerHTML = `
                    <h2>Patient Dashboard</h2>
                    <p>Welcome! You can view your medical history here.</p>
                `;
            } else if (role === 'doctor') {
                content.innerHTML = `
                    <h2>Doctor Dashboard</h2>
                    <p>Welcome! You can manage patient records and prescriptions here.</p>
                `;
            } else if (role === 'nurse') {
                content.innerHTML = `
                    <h2>Nurse Dashboard</h2>
                    <p>Welcome! You can manage shift schedules and department logs here.</p>
                `;
            } else {
                content.innerHTML = `
                    <h2>User Dashboard</h2>
                    <p>Welcome! You are logged in as a general user.</p>
                `;
            }
        }
    }

    // Role-specific search functionality (on dashboard page)
    const searchInput = document.getElementById('search-bar');
    const searchBtn = document.getElementById('search-btn');
    const searchResults = document.getElementById('search-results');

    if (searchBtn && searchInput && searchResults) {
        searchBtn.addEventListener('click', handleSearch);

        function handleSearch() {
            const query = searchInput.value.trim();
            const role = localStorage.getItem('role');

            if (!query) {
                searchResults.textContent = 'Please enter a search term.';
                return;
            }

            if (role === 'doctor') {
                searchResults.textContent = `Searching for patients related to: ${query}`;
            } else if (role === 'patient') {
                searchResults.textContent = `Searching for your medical records related to: ${query}`;
            } else if (role === 'nurse') {
                searchResults.textContent = `Searching for shift or department logs related to: ${query}`;
            } else {
                searchResults.textContent = `Performing a general search for: ${query}`;
            }
        }
    }

    // Handle signup form submission
    const signupForm = document.getElementById('signup-form');
    if (signupForm) {
        signupForm.addEventListener('submit', async (e) => {
            e.preventDefault();

            const username = document.getElementById('username').value;
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const role = document.getElementById('role').value;

            const roleSpecificData = {};
            if (role === 'patient') {
                const medicalHistory = document.getElementById('medicalHistory')?.value;
                const emergencyContact = document.getElementById('emergencyContact')?.value;
                if (!medicalHistory || !emergencyContact) {
                    alert('Please fill out all patient-specific fields.');
                    return;
                }
                roleSpecificData.medicalHistory = medicalHistory;
                roleSpecificData.emergencyContact = emergencyContact;
            } else if (role === 'doctor') {
                const specialization = document.getElementById('specialization')?.value;
                const experience = document.getElementById('experience')?.value;
                if (!specialization || !experience) {
                    alert('Please fill out all doctor-specific fields.');
                    return;
                }
                roleSpecificData.specialization = specialization;
                roleSpecificData.experience = experience;
            } else if (role === 'nurse') {
                const department = document.getElementById('department')?.value;
                const shifts = document.getElementById('shifts')?.value;
                if (!department || !shifts) {
                    alert('Please fill out all nurse-specific fields.');
                    return;
                }
                roleSpecificData.department = department;
                roleSpecificData.shifts = shifts;
            }

            try {
                const response = await fetch('http://localhost:3000/auth/signup', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ username, email, password, role, ...roleSpecificData }),
                });
                const data = await response.json();
                if (response.ok) {
                    alert('User registered successfully!');
                    window.location.href = 'login.html';
                } else {
                    alert(data.error || 'Signup failed.');
                }
            } catch (err) {
                console.error('Error during signup:', err);
                alert('An error occurred during signup.');
            }
        });
    }

    // Handle login form submission
    const loginForm = document.getElementById('login-form');
    if (loginForm) {
        loginForm.addEventListener('submit', async (e) => {
            e.preventDefault();

            const email = document.getElementById('login-email').value;
            const password = document.getElementById('login-password').value;

            try {
                const response = await fetch('http://localhost:3000/auth/login', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ email, password }),
                });
                const data = await response.json();
                if (response.ok && data.token && data.role) {
                    localStorage.setItem('token', data.token);
                    localStorage.setItem('role', data.role);
                    window.location.href = 'dashboard.html';
                } else {
                    alert(data.error || 'Invalid credentials.');
                }
            } catch (err) {
                console.error('Error during login:', err);
                alert('An error occurred during login.');
            }
        });
    }

    // Handle logout
    const logoutBtn = document.getElementById('logout-btn');
    if (logoutBtn) {
        logoutBtn.addEventListener('click', () => {
            localStorage.clear();
            alert('Logged out successfully!');
            window.location.href = 'login.html';
        });
    }
});
