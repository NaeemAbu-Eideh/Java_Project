
document.addEventListener("DOMContentLoaded", function () {

    const btn = document.getElementById("mobileMenuBtn");
    const sidebar = document.getElementById("sidebar");

    if (btn && sidebar) {
        btn.addEventListener("click", () => {
            sidebar.classList.toggle("left-0");
            sidebar.classList.toggle("left-[-300px]");
        });
    }
});

function loadRequests(status) {

    document.querySelectorAll(".side-btn").forEach(btn => {
        btn.classList.remove("bg-white", "text-yellow-600");
        btn.classList.add("text-white", "hover:bg-yellow-800");
    });

    const activeBtn = event.target.closest("button");
    activeBtn.classList.add("bg-white", "text-yellow-600");
    activeBtn.classList.remove("text-white", "hover:bg-yellow-800");

    document.querySelectorAll(".side-btn").forEach(btn => btn.classList.remove("active", "bg-white", "text-yellow-900"));
    event.target.classList.add("active", "bg-white", "text-yellow-900");

    axios.get(`/requests?status=${status}`)
        .then(res => {
            const data = res.data;

            const container = document.getElementById("requestContainer");

            if (data.length === 0) {
                container.innerHTML = `
                        <div class="bg-white rounded-lg shadow-md p-12 text-center">
                            <span class="material-symbols-outlined text-gray-300 text-7xl block mb-4">schedule</span>
                            <h3 class="text-black mb-2">No Requests Found</h3>
                            <p class="text-gray-600">No service requests have been submitted yet.</p>
                        </div>
                    `;
                return;
            }

            let html = `
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="border-b">
                                <th class="p-2">ID</th>
                                <th class="p-2">Service</th>
                                <th class="p-2">User</th>
                                <th class="p-2">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                `;

            data.forEach(r => {
                html += `
                        <tr class="border-b hover:bg-gray-50">
                            <td class="p-2">${r.id}</td>
                            <td class="p-2">${r.serviceName}</td>
                            <td class="p-2">${r.status}</td>
                        </tr>
                    `;
            });

            html += `</tbody></table>`;

            container.innerHTML = html;

        });
}