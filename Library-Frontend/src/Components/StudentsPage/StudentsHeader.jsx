// import { Button } from "@material-tailwind/react"
import { Link } from "react-router-dom"
import { Logout } from "../../API/StudentApi"
import { useNavigate } from "react-router-dom"
export const StudentHeader = ({setSearchStudent}) => {
    const navigate=useNavigate();
    return (
        <div>
            <div className="flex pt-8 px-6 lg:px-12 text-white">
                <div className="flex-auto font-bold text-xl">
                   <Link to={`/dashboard`}> Book Lending Application</Link>
                </div>
                <div className=" pr-[28%] xl:pr-[19%] 2xl:pr-[16%] hidden lg:flex">
                     {/* Allowing users to search according to student name */}
                    <input onChange={(e)=> {setSearchStudent(e.target.value);}} type="text" placeholder="Search By Name" className="rounded-xl text-black text-sm"></input>
                </div>
                <div className="flex text-xl hover:cursor-pointer" onClick={async()=>{
                    await Logout();
                    navigate("/login");
                    localStorage.removeItem("jwt");
                }}>
                    Logout
                </div>
            </div>

            {/* Button to open 'add student' modal for phone screens */}
            <div className="lg:hidden">
                <img src="/images/Pic2.png" className="object-contain flex mx-auto my-4"></img>
                <div className="mb-6 mt-10 flex">
                    <div className="flex-auto px-6">
                        <Link to={`/addstudent`}>
                            <button className="bg-[#F9D745] rounded-2xl px-8 text-black">Add</button>
                        </Link>
                    </div>
                    <div className="flex">
                        {/* Allowing users to search according to student name */}
                        <input onChange={(e)=> setSearchStudent(e.target.value)} type="text" placeholder="Search By Name" className="rounded-xl text-black text-sm w-[90%]"></input>
                    </div>
                </div>
            </div>
        </div>
    )
}