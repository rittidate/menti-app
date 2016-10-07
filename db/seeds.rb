SecurityQuestion.create! locale: :en, name: 'What was the name of the boy/girl you had your second kiss with?'
SecurityQuestion.create! locale: :en, name: 'What was the name of your first pet?'
SecurityQuestion.create! locale: :en, name: 'When you were young, what did you want to be when you grew up?'
SecurityQuestion.create! locale: :en, name: 'Who was your childhood hero? '
SecurityQuestion.create! locale: :en, name: 'What was your childhood nickname?'
SecurityQuestion.create! locale: :en, name: 'What was the name of your elementary / primary school?'
SecurityQuestion.create! locale: :en, name: 'What is your oldest cousin\'s first and last name?'

financial = Category.create! name: 'Financial'
spirit = Category.create! name: 'Spiritual' 
health = Category.create! name: 'Health and Fitness' 
education = Category.create! name: 'Education'
relation = Category.create! name: 'Relationships'
career = Category.create! name: 'Career' 

#seen

Category.create! name: 'Financial Advice', parent_id: financial.id
Category.create! name: 'Accounting', parent_id: financial.id
Category.create! name: 'Business start up', parent_id: financial.id
Category.create! name: 'Savings plan', parent_id: financial.id
Category.create! name: 'Buying a house', parent_id: financial.id
Category.create! name: 'Job search', parent_id: career.id
Category.create! name: 'Career advice', parent_id: career.id
Category.create! name: 'Goal setting', parent_id: career.id
Category.create! name: 'Goal achievement', parent_id: career.id
Category.create! name: 'Spiritual alignment', parent_id: spirit.id
Category.create! name: 'Spiritual engagement', parent_id: spirit.id
Category.create! name: 'Community involvement', parent_id: relation.id
Category.create! name: 'Work/life balance', parent_id: relation.id
Category.create! name: 'Parental support', parent_id: relation.id
Category.create! name: 'Ageing parents', parent_id: relation.id
Category.create! name: 'Young children', parent_id: relation.id
Category.create! name: 'Child support', parent_id: relation.id
Category.create! name: 'Training', parent_id: education.id
Category.create! name: 'Educational pathways', parent_id: education.id
Category.create! name: 'Leadership growth', parent_id: education.id
Category.create! name: 'Healthy mind', parent_id: health.id
Category.create! name: 'Healthy body', parent_id: health.id
Category.create! name: 'Fitness techniques', parent_id: health.id 
Category.create! name: 'Personal fitness training', parent_id: health.id
Category.create! name: 'Nutritional support', parent_id: health.id
