package models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Role {

	

		public Role(int id) {
		super();
		this.id = id;
	}

		private int id;
		
		private String name;
		
}
