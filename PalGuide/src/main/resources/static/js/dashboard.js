
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

                // Format date manually (JS doesn't have Thymeleaf's #temporals)
                let createdAt = new Date(r.createdAt);
                let formattedDate = createdAt.toLocaleDateString("en-US", {
                    day: "2-digit",
                    month: "short",
                    year: "numeric"
                });

                // Build status pill
                let statusHtml = "";
                switch (r.status) {
                    case "PENDING":
                        statusHtml = `
                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-yellow-100 text-yellow-700">
                    <span class="w-2 h-2 rounded-full bg-yellow-500 mr-1"></span>
                    Pending
                </span>`;
                        break;

                    case "IN_PROGRESS":
                        statusHtml = `
                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-blue-100 text-blue-700">
                    <span class="w-2 h-2 rounded-full bg-blue-500 mr-1"></span>
                    In Progress
                </span>`;
                        break;

                    case "UNDER_REVIEW":
                        statusHtml = `
                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-indigo-100 text-indigo-700">
                    <span class="w-2 h-2 rounded-full bg-indigo-500 mr-1"></span>
                    Under Review
                </span>`;
                        break;

                    case "COMPLETED":
                        statusHtml = `
                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-700">
                    <span class="w-2 h-2 rounded-full bg-green-500 mr-1"></span>
                    Completed
                </span>`;
                        break;

                    case "REJECTED":
                        statusHtml = `
                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-red-100 text-red-700">
                    <span class="w-2 h-2 rounded-full bg-red-500 mr-1"></span>
                    Rejected
                </span>`;
                        break;

                    default:
                        statusHtml = `
                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-gray-100 text-gray-700">
                    <span class="w-2 h-2 rounded-full bg-gray-400 mr-1"></span>
                    ${r.status}
                </span>`;
                }

                // Build card HTML
                html += `
        <div class="bg-white rounded-2xl shadow-md hover:shadow-xl transition-all border border-gray-100 p-6">

            <div class="flex items-start justify-between mb-4">
                <div>
                    <p class="text-xs uppercase tracking-wide text-gray-400">${formattedDate}</p>
                    <h2 class="text-lg font-semibold text-gray-900">${r.user.firstname} ${r.user.lastname}</h2>
                    <p class="text-xs font-medium text-gray-500 mt-1">${r.type}</p>
                </div>

                ${statusHtml}
            </div>

            <dl class="grid grid-cols-2 gap-3 text-sm text-gray-700">

                <div class="col-span-2">
                    <dt class="font-semibold text-gray-500">Title</dt>
                    <dd class="mt-1 text-gray-900">${r.title}</dd>
                </div>

                <div class="col-span-2">
                    <dt class="font-semibold text-gray-500">Description</dt>
                    <dd class="mt-1 text-gray-700">${r.description}</dd>
                </div>

                <div>
                    <dt class="font-semibold text-gray-500">Amount</dt>
                    <dd class="mt-1 font-semibold text-emerald-600">${r.amount} USD</dd>
                </div>

                <div>
                    <dt class="font-semibold text-gray-500">Payment</dt>
                    <dd class="mt-1 text-gray-800">${r.paymentStatus}</dd>
                </div>
            </dl>

            <div class="mt-5 flex items-center justify-between border-t pt-3">
                <p class="text-xs text-gray-400">ID #${r.id}</p>

                <a href="/requests/${r.id}"
                   class="inline-flex items-center text-xs font-medium text-blue-600 hover:text-blue-800">
                    View details
                    <span class="material-symbols-outlined text-sm ml-1">arrow_forward</span>
                </a>
            </div>

        </div>
    `;
            });


            html += `</div>`;


            container.innerHTML = html;

        });
}