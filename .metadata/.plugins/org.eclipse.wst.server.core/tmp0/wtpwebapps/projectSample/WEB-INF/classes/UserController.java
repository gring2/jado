

import org.apache.ibatis.session.SqlSession;
import org.scit.app.persistence.UserDao;
import org.scit.app.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserController {
	@Autowired
	SqlSession sqlSession;
	@RequestMapping(value="joinView", method=RequestMethod.GET)
	public String join(){
		return "user/joinView";
	}
	@RequestMapping(value="join", method=RequestMethod.GET)
	public String join(User user){
		UserDao dao = sqlSession.getMapper(UserDao.class);
		dao.insertUser(user);
		return "join/joinComplete";
	}
	@RequestMapping(value="idCheck", method=RequestMethod.POST)
	public @ResponseBody String idCheck(@RequestBody String id, User user){
		System.out.println(id);
		System.out.println("ddd");
		UserDao dao = sqlSession.getMapper(UserDao.class);
		User usr = dao.selectUser(user);
		String message = null;
		if(usr !=null){
			message="fail";
		}else{
			message = "success";
		}
		return message;
	}

}