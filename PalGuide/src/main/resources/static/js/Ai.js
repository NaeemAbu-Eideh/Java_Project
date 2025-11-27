pdfjsLib.GlobalWorkerOptions.workerSrc =
    "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js";

const uploadArea = document.getElementById("uploadArea");
const uploadLabel = document.getElementById("uploadLabel");
const fileInput = document.getElementById("fileUpload");
const preview = document.getElementById("filePreview");
const previewIcon = document.getElementById("previewIcon");
const changeBtn = document.getElementById("changeFileBtn");
const analyzeBtn = document.getElementById("analyzeBtn");
const errorMsg = document.getElementById("errorMsg");
const pdfModal = document.getElementById("pdfModal");
const pdfFullCanvas = document.getElementById("pdfFullCanvas");

const imgModal = document.getElementById("imgModal");
const imgFullPreview = document.getElementById("imgFullPreview");

imgModal.addEventListener("click", () => {
    imgModal.classList.add("hidden");
});


window.currentPdfFile = null;
pdfModal.classList.add("hidden");
pdfFullCanvas.getContext("2d").clearRect(0, 0, pdfFullCanvas.width, pdfFullCanvas.height);


previewIcon.addEventListener("click", async () => {
    if (!window.currentPdfFile) return;

    pdfModal.classList.remove("hidden");

    const pdf = await pdfjsLib.getDocument(window.currentPdfFile).promise;
    const page = await pdf.getPage(1);

    const viewport = page.getViewport({ scale: 1.8 });
    const ctx = pdfFullCanvas.getContext("2d");

    pdfFullCanvas.width = viewport.width;
    pdfFullCanvas.height = viewport.height;

    await page.render({ canvasContext: ctx, viewport }).promise;
});


pdfModal.addEventListener("click", () => {
    pdfModal.classList.add("hidden");
});

uploadLabel.addEventListener("click", () => (fileInput.value = ""));
changeBtn.addEventListener("click", () => {
    fileInput.value = "";
    fileInput.click();
});

fileInput.addEventListener("change", (e) => {
    const file = e.target.files[0];
    handleFile(file);
});

async function handleFile(file) {

    if (!file) return;

    window.currentPdfFile = null;
    pdfModal.classList.add("hidden");
    pdfFullCanvas.getContext("2d").clearRect(0, 0, pdfFullCanvas.width, pdfFullCanvas.height);

    uploadLabel.classList.add("hidden");
    preview.classList.remove("hidden");
    analyzeBtn.classList.remove("hidden");
    uploadArea.classList.add("border-yellow-500");

    errorMsg.classList.add("hidden");

    document.getElementById("fileName").textContent = file.name;
    document.getElementById("fileSize").textContent =
        `${(file.size / 1024 / 1024).toFixed(2)} MB`;

    previewIcon.innerHTML = "";

    const type = file.type.toLowerCase();

    if (type.includes("image")) {

        const imgURL = URL.createObjectURL(file);

        const img = document.createElement("img");
        img.src = imgURL;
        img.className = "w-32 h-32 object-cover rounded-lg shadow-md cursor-pointer transition hover:scale-105";

        previewIcon.appendChild(img);

        previewIcon.onclick = () => {
            imgFullPreview.src = imgURL;
            imgModal.classList.remove("hidden");
        };

        return;
    }


    if (type.includes("pdf")) {
        window.currentPdfFile = URL.createObjectURL(file);

        const canvas = document.createElement("canvas");
        canvas.className = "pdf-thumb shadow-md";
        previewIcon.appendChild(canvas);

        const pdf = await pdfjsLib.getDocument(window.currentPdfFile).promise;
        const page = await pdf.getPage(1);

        const viewport = page.getViewport({ scale: 0.5 });
        const context = canvas.getContext("2d");

        canvas.width = viewport.width;
        canvas.height = viewport.height;

        await page.render({ canvasContext: context, viewport }).promise;

        previewIcon.style.cursor = "pointer";
        return;
    }

    if (type.includes("word") || file.name.endsWith(".docx")) {
        previewIcon.innerHTML =
            `<span class="material-symbols-outlined text-blue-600 text-6xl">description</span>`;
        previewIcon.style.cursor = "default";
        return;
    }

    previewIcon.innerHTML =
        `<span class="material-symbols-outlined text-red-500 text-6xl">error</span>`;
    errorMsg.textContent = "Unsupported file type!";
    errorMsg.classList.remove("hidden");
    analyzeBtn.classList.add("hidden");
}


analyzeBtn.addEventListener("click", () => {
    uploadArea.classList.add("opacity-50", "pointer-events-none");
    analyzeBtn.classList.add("hidden");
    document.getElementById("loadingBox").classList.remove("hidden");
});
