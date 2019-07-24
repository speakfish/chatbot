package com.ecom.chatbot.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ecom.chatbot.entity.QuestionAnswer;
import com.ecom.core.action.TempletAction;
import com.ecom.core.entity.CorePo;
import com.ecom.core.model.TempletTypeEnum;

@Controller
@RequestMapping(value = "/chatbot/questionAnswer")
public class QuestionAnswerAction extends TempletAction {
    @Override
    protected Class<? extends CorePo> getEntityClass() {
        return QuestionAnswer.class;
    }

    @Override
    protected TempletTypeEnum getTempleType() {
        return TempletTypeEnum.SINGLE_CRUD_PAGE;
    }

    @Override
    protected String getTemplePage() {
        return "/chatbot/questionAnswer-list";
    }

}
