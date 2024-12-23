// import { Button } from "@material-tailwind/react"
import { useState } from "react";
import { Link } from "react-router-dom";
import { AddedBookMessageDialog } from "./AddedBookMessageModal";
import { addBook } from "../../API/baseApi";
export const AddBook = () => {

    // State variables for adding a book
    const [name, setName]=useState("");
    const [email, setEmail]=useState("");
    const [phone, setPhone]=useState("");
    const [rollno, setRollno]=useState("");
    const [erroremail, setErroremail]=useState("");
    const [errorphone, setErrorphone]=useState("");
    const [errorname, setErrorname]=useState("");
    const [errorrollno, setErrorrollno]=useState("");

    // State variables to control displaying of modals
    const [addedModal,setAddedModal] = useState(null);
    const [addedStudentDialogMessage, setAddedStudentDialogMessage] = useState("")

    // Functions to control the values of the state variables
    const handleEmailChange=(e)=>{
        let text=e.target.value;
        setErroremail("")
        setEmail(text);
    }

    const handlePhoneChange=(e)=>{
        setErrorphone("")
        setPhone(e.target.value);
        
    }

    const handleNameChange=(e)=>{
        setName(e.target.value);
        setErrorname("")
    }

    const handleRollnoChange=(e)=>{
        let text=e.target.value;
        if(text.includes("/")) setErrorrollno("Code can't have '/'")
        else setErrorrollno("");
        setRollno(e.target.value);
    }

    const handleSubmit=async(e)=>{
        e.preventDefault();
        if(phone=="" || email=="" || name=="" || rollno==""){
            if(email=="") setErroremail("Required Field");
            if(phone=="") setErrorphone("Required Field");
            if(name=="") setErrorname("Required Field");
            if(rollno=="") setErrorrollno("Required Field");
        }

        else if(erroremail=="" && errorphone=="" && errorname=="" && errorrollno=="")
        {
            // Adding a book after all checks are passed
            await addBook({title:name ,author:email,description:phone,code:rollno},setAddedStudentDialogMessage);

            setAddedModal('default');
        }
        
    }

    return (
        <div className="col-span-1 pt-6 lg:pr-8 bg-blue-550 min-h-screen lg:min-h-fit lg:bg-transparent ">
            {/* For phone screens, the add Book Modal opens in a separate screen */}
            <div className="flex pt-2 px-12 text-white lg:hidden">
                <div className="hover:cursor-pointer flex-auto text-white font-bold text-xl ">
                    <Link to={`/dashboard`}>Book Lending Application</Link>
                </div>
                <div className=" pr-[20%] hidden lg:flex">
                    <input type="text" placeholder="Search" className="rounded-xl text-black text-sm"></input>
                </div>
                <div className="flex text-xl">
                    Logout
                </div>
            </div>
            
            <div className="text-white font-bold text-2xl text-center pt-12">
                Add Book
            </div>
            
            <div className="lg:bg-[#F9D745] rounded-lg mt-3 py-3 ">
                <div className="w-full ">
                    <img src="/images/Pic1.png" className="object-contain flex mx-auto"></img>
                </div>
                <div className="mt-6 text-white lg:text-black">
                    
                    <div className="col-span-4 lg:col-span-3 xl:col-span-4 flex justify-end items-center">
                        {/* Displaying a modal after a book has been added */}
                        <AddedBookMessageDialog openModal={addedModal} setOpenModal={setAddedModal} message={addedStudentDialogMessage} />
                    </div>
                    
                    <form>
                        {/* Adding book details */}
                        <div className=" w-4/5 mx-auto">
                            <div className="text-sm lg:text-gray-600 text-white">Title</div>
                                <input type="text" className="border-0 border-b-2  border-white lg:border-black text-[16px] mt-1  focus:ring-0 focus:border-white lg:focus:border-black px-0 placeholder:text-white lg:placeholder:text-blue-550  bg-transparent w-full" placeholder="Enter Book Title" value={name} onChange={handleNameChange}/>
                            <div className="mt-1 text-red-600 text-sm">{errorname}</div>

                        </div>
                        <div className="mt-8 w-4/5 mx-auto">
                            <div className="text-sm lg:text-gray-600 text-white">Author</div>
                                <input type="text" className="border-0 border-b-2   border-white lg:border-black text-[16px] mt-1  focus:ring-0 lg:focus:border-black focus:border-white px-0 placeholder:text-white lg:placeholder:text-blue-550  bg-transparent w-full" placeholder="Enter Author Name" value={email} onChange={handleEmailChange}/>
                            <div className="mt-1 text-red-600 text-sm">{erroremail}</div>

                        </div>

                        <div className="mt-8 w-4/5 mx-auto">
                            <div className="text-sm lg:text-gray-600 text-white">Description</div>
                                <input type="text" className="border-0 border-b-2  border-white lg:border-black text-[16px] mt-1  focus:ring-0 focus:border-white lg:focus:border-black px-0 placeholder:text-white lg:placeholder:text-blue-550  bg-transparent w-full" placeholder="Enter Description" value={phone} onChange={handlePhoneChange}/>
                            <div className="mt-1 text-red-600 text-sm">{errorphone}</div>
                        </div>

                        <div className="mt-8 w-4/5 mx-auto">
                            <div className="text-sm lg:text-gray-600 text-white">Code</div>
                                <input type="text" className="border-0 border-b-2  border-white lg:border-black text-[16px] mt-1  focus:ring-0 focus:border-white lg:focus:border-black px-0 placeholder:text-white lg:placeholder:text-blue-550  bg-transparent w-full" placeholder="Enter Code" value={rollno} onChange={handleRollnoChange}/>
                            <div className="mt-1 text-red-600 text-sm">{errorrollno}</div>
                        </div>
                        

                        <div className="flex justify-center mx-auto w-4/5 mt-12 mb-3">
                            {/* Adding the new book */}
                            <button className="bg-[#F9D745] lg:bg-blue-550 w-full rounded-xl py-4 text-blue-550 lg:text-white" onClick={handleSubmit}>Add</button>
                        </div>
                        <div className="flex justify-center mx-auto w-4/5 mt-6 mb-3">
                            {/* Button to go back to the books page */}
                            <Link to={`/books`}><button className="bg-[#F9D745]  lg:hidden  rounded-xl py-4 text-blue-550 ">Return</button></Link>
                        </div>
                        
                    </form>
                </div>
                    
            </div>
        </div>
    )
}