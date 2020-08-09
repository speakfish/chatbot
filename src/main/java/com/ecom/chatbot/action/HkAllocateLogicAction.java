package com.ecom.chatbot.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ecom.chatbot.entity.HkAllocateLogic;
import com.ecom.chatbot.entity.QuestionAnswer;
import com.ecom.core.action.TempletAction;
import com.ecom.core.entity.CorePo;
import com.ecom.core.model.TempletTypeEnum;

@Controller
@RequestMapping(value = "/hk/allocateLogic")
public class HkAllocateLogicAction extends TempletAction {
    @Override
    protected Class<? extends CorePo> getEntityClass() {
        return HkAllocateLogic.class;
    }

    @Override
    protected TempletTypeEnum getTempleType() {
        return TempletTypeEnum.SINGLE_CRUD_PAGE;
    }

    @Override
    protected String getTemplePage() {
        return "/hk/allocateLogic-list";
    }

}
