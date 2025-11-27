
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

function loadRequests(status, event) {

    document.querySelectorAll(".side-btn").forEach(btn => {
        btn.classList.remove("bg-white", "text-yellow-600");
        btn.classList.add("text-white", "hover:bg-yellow-800");
    });

    const activeBtn = event.target.closest("button");
    activeBtn.classList.add("bg-white", "text-yellow-600");
    activeBtn.classList.remove("text-white", "hover:bg-yellow-800");

    document.querySelectorAll(".side-btn").forEach(btn => btn.classList.remove("active", "bg-white", "text-yellow-900"));
    event.target.classList.add("active", "bg-white", "text-yellow-900");

    axios.get(`/dash/api?status=${status}`)
        .then(res => {
            const data = res.data;
            const container = document.getElementById("requestContainer");

            console.log("DATA:", data);

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
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
`;

            data.forEach(r => {
                html += `
        <div class="bg-white shadow-lg rounded-xl p-6 border border-gray-200 hover:shadow-xl transition">

            <h2 class="text-xl font-semibold text-gray-800 mb-2">
                ${r.user.firstname} ${r.user.lastname}
            </h2>

            <div class="space-y-2 text-gray-600">

                <p>
                    <span class="font-semibold text-gray-700">Type:</span>
                    ${r.type}
                </p>

                <p>
                    <span class="font-semibold text-gray-700">Title:</span>
                    ${r.title}
                </p>

                <p>
                    <span class="font-semibold text-gray-700">Description:</span>
                    ${r.description}
                </p>

                <p>
                    <span class="font-semibold text-gray-700">Status:</span>
                    ${r.status}
                </p>

            </div>

        </div>
    `;
            });

            html += `</div>`;


            container.innerHTML = html;

        });
}