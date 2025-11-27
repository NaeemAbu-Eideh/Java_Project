function showForm(self){
    staticForm = document.querySelector("#static");
    formForm = document.querySelector("#form");

    staticForm.classList.add("hidden")
    formForm.classList.remove("hidden");

}

function showDetails(self){
    staticForm = document.querySelector("#static");
    formForm = document.querySelector("#form");

    staticForm.classList.add("block")
    staticForm.classList.remove("hidden")
    formForm.classList.remove("block");
    formForm.classList.add("hidden");
}

function showAddress(self){
    addressForm = document.querySelector("#address");

    if(self.innerText == "Add new Address"){
        address.classList.add("block");
        address.classList.remove("hidden");
        self.innerText = "Cancel";
    }
    else{
        address.classList.add("hidden");
        address.classList.remove("block");
        self.innerText = "Add new Address";
    }
}

function hideAddress(){
    newAddress = document.querySelector("#newAddress");
    addressForm = document.querySelector("#address");
    address.classList.add("hidden");
    address.classList.remove("block");
    newAddress.innerText = "Add new Address";
}