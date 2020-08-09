package com.ecom.note.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ecom.core.action.TempletAction;
import com.ecom.core.entity.CorePo;
import com.ecom.core.model.TempletTypeEnum;
import com.ecom.note.entity.NoteAnything;

@Controller
@RequestMapping(value = "/note/anything")
public class NoteAnythingAction extends TempletAction {
    @Override
    protected Class<? extends CorePo> getEntityClass() {
        return NoteAnything.class;
    }

    @Override
    protected TempletTypeEnum getTempleType() {
        return TempletTypeEnum.SINGLE_CRUD_PAGE;
    }

    @Override
    protected String getTemplePage() {
        return "/note/anything-list";
    }

}
