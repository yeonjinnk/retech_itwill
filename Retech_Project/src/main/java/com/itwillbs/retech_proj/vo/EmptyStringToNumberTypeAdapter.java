package com.itwillbs.retech_proj.vo;

import java.io.IOException;

import com.google.gson.JsonSyntaxException;
import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;

//sendMessage에서 pd_idx를 공백으로 둘 때 0으로 받기 위해 만든 클래스
public class EmptyStringToNumberTypeAdapter extends TypeAdapter<Number> {

	@Override
	public void write(JsonWriter jsonWriter, Number number) throws IOException {
		 if (number == null) {
	            jsonWriter.nullValue();
	            return;
	        }
	        jsonWriter.value(number);

	}

	@Override
	public Number read(JsonReader jsonReader) throws IOException {
		if (jsonReader.peek() == JsonToken.NULL) {
            jsonReader.nextNull();
            return null;
        }

        try {
            String value = jsonReader.nextString();
            if ("".equals(value)) {
                return 0;
            }
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            throw new JsonSyntaxException(e);
        }
	}

}
