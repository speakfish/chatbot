package com.ecom.dict.model;

public class DictModel {
    private String value;
    private String text;

    public DictModel() {
    }

    public DictModel(String code, String name) {
        this.value = code;
        this.text = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
