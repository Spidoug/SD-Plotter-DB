void readnormal()
{
  value0 = analogRead(analogPin0);
  value1 = analogRead(analogPin1);
  value2 = analogRead(analogPin2);
  value3 = analogRead(analogPin3);
  value4 = analogRead(analogPin4);
  value5 = analogRead(analogPin5);
  value7 = digitalRead(Pin4);
  value8 = digitalRead(Pin5);
  value9 = filtered6final;
}

void readsmooth()
{
  datax0 = analogRead(analogPin0);
  sum0 = sum0 - filtered0 + datax0;
  filtered0 = sum0 >> beta0;

  datax1 = analogRead(analogPin1);
  sum1 = sum1 - filtered1 + datax1;
  filtered1 = sum1 >> beta1;

  datax2 = analogRead(analogPin2);
  sum2 = sum2 - filtered2 + datax2;
  filtered2 = sum2 >> beta2;

  datax3 = analogRead(analogPin3);
  sum3 = sum3 - filtered3 + datax3;
  filtered3 = sum3 >> beta3;

  datax4 = analogRead(analogPin4);
  sum4 = sum4 - filtered4 + datax4;
  filtered4 = sum4 >> beta4;

  datax5 = analogRead(analogPin5);
  sum5 = sum5 - filtered5 + datax5;
  filtered5 = sum5 >> beta5;
  
  value0 = filtered0;
  value1 = filtered1;
  value2 = filtered2;
  value3 = filtered3;
  value4 = filtered4;
  value5 = filtered5;
  value7 = digitalRead(Pin4);
  value8 = digitalRead(Pin5);
  value9 = filtered6final;
}
