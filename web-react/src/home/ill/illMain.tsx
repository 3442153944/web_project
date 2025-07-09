import Tags from "@/home/common/tags.tsx";
import baseApi from "@/BaseApi.ts";
import {useEffect, useState} from "react";
import {type ResType} from "@/types/resTypes.ts";


const IllMain = () => {
    const api=baseApi;
    const [tags,setTags]=useState<string[]|undefined>(undefined)
    const tagTest=()=>{
        const tag=[]
        for(let i=0;i<10;i++){
            tag.push(`插画${i}`)
        }
        return tag
    }
    useEffect(() => {
        (async()=>{
            const getTags=async()=>{
                  try{
                      const res:ResType<string[]> | null=await api.post("api/GetFollowUserIllTags",{})
                      if(res&&res.code==200){
                          setTags([...res.data,...tagTest()])
                          console.log("res:",res)
                      }
                      else{
                          console.warn(res)
                      }
                  }
                  catch(e){
                      console.warn(e)
                  }
            }
            await getTags()
        })()
    }, []);
    return (<>
    <div>
        插画主页面
        <Tags tags={tags}></Tags>
    </div>
    </>)
}
export default IllMain;